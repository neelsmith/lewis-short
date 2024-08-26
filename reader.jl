using Markdown
using Downloads

scriptversion = "1.1.0"

"""Sort articles following the Blackwell algorithm: exact lemma match comes out on top, then lemma substrings alphabetically sorted, then remaining articles in alphabetical order."""
function blackwell_sort(matches, lemmastring)
	lemmarestring = "([^\\|]+)\\|([^\\|]+)\\|$(lemmastring)(.*)"
	lemmare = Regex(lemmarestring)
	top = filter(s -> occursin(lemmare, s), matches)

	lemmaanyrestring = "([^\\|]+)\\|([^\\|]+)\\|[^\\|]*$(lemmastring)[^\\|]*\\|(.*)"
	lemma_any_re = Regex(lemmaanyrestring)
	middle = filter(s -> occursin(lemma_any_re, s) && ! (occursin(lemmare, s)) , matches)
	
	bottom = filter(s -> (! occursin(lemma_any_re, s)) && (! (occursin(lemmare, s))) , matches)
	
	vcat(top, middle, bottom)
end

function format(entries)
    formatted = map(entries) do entry
        cols = split(entry,"|")
        urn = cols[2]
        lemma = cols[3]
        text = cols[4]
        string("## *", lemma, "*\n\n`", urn,"`\n\n", text)
    end
    join(formatted, "\n\n")
end

function read_ls(remote = true)
    if remote
        url = "http://shot.holycross.edu/lexica/ls-articles.cex"
        f = Downloads.download(url)
        content = readlines(f)
        rm(f)
        content

    else
        f = "ls-articles.cex"
        readlines(f)
    end
end


function text(s; articles = articles)
    matches = filter(article -> occursin(s,article), articles)
    formatted = blackwell_sort(matches, s) |> format
    article = length(matches) == 1 ? "article" : "articles"
    hdr = """# $(length(matches)) $(article) matching *$(s)*\n\n""" 
    string(hdr, formatted)
end

function id(s; articles = articles)
    pttrn = "urn:cite2:hmt:ls.markdown:" * s * "\\|"
    re = Regex(pttrn)
    matches = filter(article -> occursin(re,article), articles)
    formatted = blackwell_sort(matches, s) |> format
    article = length(matches) == 1 ? "article" : "articles"
    hdr = """# $(length(matches)) $(article) for ID *$(s)*\n\n""" 
    string(hdr, formatted)
end

function lemma(s; articles = articles)
    pttrn = "$(s).*\\|.+"
    re = Regex(pttrn)
    matches = filter(article -> occursin(re,article), articles)
    formatted = blackwell_sort(matches, s) |> format
    article = length(matches) == 1 ? "article" : "articles"
    hdr = """# $(length(matches)) $(article) with lemma matching *$(s)*\n\n""" 
    string(hdr, formatted)
end

function versioninfo()
"""
## Version history:

- 1.1.0: break out distinct functions for lemma, id and text
- 1.0.0: initial release
"""
end

@info("Script version: $(scriptversion)")
@info("To see version info:")
@info("   versioninfo() |> Markdown.parse\n\n")
@info("Downloading Lewis-Short dictionary...")
articles = read_ls()
@info("Complete.")
@info("\nUse one of these to view formatted articles in your REPL.")
@info("\nFind article by ID:")
@info("    id(IDVALUE) |> Markdown.parse\n")
@info("\nFind matching lemma:")
@info("    lemma(STRING) |> Markdown.parse\n")
@info("\nFull-text search:")
@info("    text(STRING) |> Markdown.parse\n")



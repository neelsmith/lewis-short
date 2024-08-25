using Markdown
using Downloads



# Format of entries for each article:
# "sequence|urn|key|entry"
"""Find articles containing string `s` and format
for markdown display.
"""
function display(s, articles = articles)
    matches = filter(article -> occursin(s,article), articles)
    entries = map(matches) do entry
        cols = split(entry,"|")
        urn = cols[2]
        lemma = cols[3]
        text = cols[4]
        string("## ", lemma, "\n\n`", urn,"`\n\n", text)
    end

    article = length(matches) == 1 ? "article" : "articles"
    hdr =  """# $(length(matches)) $(article) matching *$(s)*\n\n""" 
    string(hdr, join(entries,"\n\n"))
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

@info("Downloading Lewis-Short dictionary...")
articles = read_ls()
@info("Complete.")
@info("\nTo view formatted articles in your REPL:")
@info("    display(TERM) |> Markdown.parse\n")
# Example:
#display("|maneo")
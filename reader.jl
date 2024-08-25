using Markdown
# Format of entries for each article:
# "sequence|urn|key|entry"
f = "ls-articles.cex"
articles = readlines(f)

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



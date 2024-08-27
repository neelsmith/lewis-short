# Simple Lewis-Short dictionary

Interactively search and read content of Lewis and Short's *Latin Dictionary* using Julia.

> Prerequisites: [the Julia language](https://julialang.org/downloads/).


## Using a Pluto notebook

Prerequisites: add the Pluto package.  (E.g., at the Julia REPL, `] add Pluto`.)

- choose a search type (lemma, article ID, full text)
- submit a search term
- if searching by lemma, optionally limit search to matching beginning of lemma
- optionally, download the collection of articles and uncheck *Use online copy of dictionary* to work offline

!["Pluto notebook"](./lewis-short-plutonb.gif)

## From a Julia REPL

At a Julia REPL:

```{julia}
julia> include("reader.jl")
```

Read an article identified by ID:


```{julia}
julia> id("n15097") |> Markdown.parse
```

Read articles with lemmas matching a string:

```{julia}
julia> lemma("echinus") |> Markdown.parse
```
> **Tip**: you can limit matches to lemmas beginning with the search string with an optional `initial` argument.
>
> ```{julia}
> julia> lemma("vocabulum")
> "# 2 articles with lemma matching *vocabulum*\n\n## *vocabulum*\n\n`urn:cite2:hmt:ls.markdown:n51245`\n\nvŏcābŭlum, i, n. id., `I` *an appellation*, *designation*, *name* of any thing (cf.: nomen, vox). `I` In gen.: philosophorum habent disciplinae ex ipsis Vocabula, Ter. Eun. 2, 2, " ⋯ 1373 bytes ⋯ "et equus, et legit et currit, Varr. L. L. 8, §§ 11, 12, 45, 52 sq., 80 Müll; Quint. 1, 4, 20; Sen. Ep. 58, 6. \n\n## *provocabulum*\n\n`urn:cite2:hmt:ls.markdown:n39221`\n\nprō-vŏcābŭlum, i, n., `I` *a word that is used for another*, *a pronoun*, Auct. ap. Varr. L. L. 8, § 45 Müll. "
>
> julia> lemma("vocabulum"; initial = true)
> "# 1 article with lemma matching *vocabulum*\n\n## *vocabulum*\n\n`urn:cite2:hmt:ls.markdown:n51245`\n\nvŏcābŭlum, i, n. id., `I` *an appellation*, *designation*, *name* of any thing (cf.: nomen, vox). `I` In gen.: philosophorum habent disciplinae ex ipsis Vocabula, Ter. Eun. 2, 2, 3" ⋯ 1205 bytes ⋯ "llative noun in partic. (in contradistinction to nomen, as denoting a proper name; v. nomen): Aristoteles orationis duas partes esse dicit, vocabula et verba, ut homo et equus, et legit et currit, Varr. L. L. 8, §§ 11, 12, 45, 52 sq., 80 Müll; Quint. 1, 4, 20; Sen. Ep. 58, 6. "
> ```

Read articles with any text matching a string:

```{julia}
julia> text("hedgehog") |> Markdown.parse
```

> **Tip**: if you just want to see how many articles match a term, use any of the above functions without `Markdown.parse`.  Example:
>
> ```{julia}
> julia> text("Cic.")
> "# 11837 articles matching *Cic.*\n\n## *A1*\n\n`urn:cite2:hmt:ls.markdown:n0`\n\nA, a, indecl. n. (sometimes joined with `I` *littera*), the first letter of the Latin alphabet, corresponding to the a, α of the other Indo-. European languages: A primum est: hinc incipiam, et" ⋯ 19753529 bytes ⋯ ".2` Zōpŭriātim, adv., *in the manner of Zopyrus*, Lucil. ap. Non. p. 455, 17. \n\n## *Zoster2*\n\n`urn:cite2:hmt:ls.markdown:n51584`\n\nZoster, ēris, m., `I` *a promontory*, *town*, *and harbor of Attica;* the promontory is now called *C. Lombarda*, Cic. Att. 5, 12 *init.*
> ```
>
> That's right: *passages of Cicero are cited in 23% of all articles in Lewis-Short*! (11837 / 51597)


!["REPL"](./lewis-short-repl-1.1.gif)


## About the dictionary

The Julia script and Pluto notebook search articles extracted from a digital edition of Lewis and Short's *Latin Dictionary* in Markdown formatting by Christopher Blackwell, and [freely available on github](https://github.com/Eumaeus/cex_lewis_and_short).

The articles are in a simple delimited-text format with a sequence number, an identifying CITE2 URN, a lemma string, and the full article. 

## Working offline

You can download the extracted articles [here](http://shot.holycross.edu/lexica/ls-articles.cex). If you download the articles into the root directory of this repository, you can run the Julia scripts and Pluto notebook offline.

To use the REPL scripts offline:

```{julia}
julia> include("reader.jl")
[ Info: Downloading Lewis-Short dictionary...
[ Info: Complete.
┌ Info: 
└ To view formatted articles in your REPL:
[ Info:     display(TERM) |> Markdown.parse

julia> articles = read_ls(remote = false)

```


To use the Pluto notebook offline:

- unchecking the checkbox option labelled *Use online copy of dictionary*.

# Simple Lewis-Short dictionary

Interactively search and read content of Lewis and Short's *Latin Dictionary* using Julia.

> Prerequisites: [the Julia language](https://julialang.org/downloads/).


## Using a Pluto notebook

Prerequisites: add the Pluto package.  (E.g., at the Julia REPL, `] add Pluto`.)

!["Pluto notebook"](./lewis-short-plutonb.gif)

## From a Julia REPL


!["REPL"](./lewis-short-repl.gif)


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

---
title: "GeneticData"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## The Tree of Life

First, we need to do some installs.

```{r, eval = FALSE}
install.packages("devtools")
devtools::install_github("ropensci/rotl")
devtools::install_github("ropensci/traits")
#install.packages('phylotaR')
```

Now, load your packages:


```{r }
library(rotl)
#library(phylotaR)
```

## Open Tree

First, we're going to look for some data. Discuss with your neighbor a clade you like and want to build a tree of. For example, perhaps I really like hominids. 
```{r echo=FALSE}
apes <- c("Pongo", "Pan", "Gorilla", "Hoolock", "Homo")
(resolved_names <- tnrs_match_names(apes))
```
Put the names of five genera into the function. If you want, you can use mine below.

```{r echo=FALSE}
ants <- c("Martialis", "Atta", "Ectatomma", "Tatuidris", "Aneuretus", "Xymmer", "Aenictus")
(resolved_names <- tnrs_match_names(ants))
```


Try to view them on a tree:

```{r}
tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))
plot(tr)
```

I'm a little surprised by this tree. 

## Looking for data

We're going to try to build a tree of these taxa from GenBank Data. Much like accessing NOAA data, we will need to make an API Key. Go [here](https://www.ncbi.nlm.nih.gov/account/) and register.

Now that we have that key, we can access NCBI:

```{r}
library(rentrez)
entrez_search(db = "Nucleotide", term="Ectatomma", api_key ="96b569c049fe3d3055c5b747112dfec84308")
```


Holy moley that's a lot of data. If we do that for every taxon, we'll end up with a mess. Why don't we try to filter it a bit.


```{r}
Ectatomma <- entrez_search(db = "Nucleotide", term="Ectatomma AND 2018:2019[PDAT]", retmax = 100, api_key ="96b569c049fe3d3055c5b747112dfec84308")
```

So there is a good amount of data for our Ectatomma ants.


```{r}
for( seq_start in seq(1,50,100)){
     recs <- entrez_fetch(db="nuccore", id = Ectatomma$ids,
                          rettype="fasta", retmax=50, retstart=seq_start)
     cat(recs, file="Ect.seqs.fasta", append=TRUE)
     cat(seq_start+49, "sequences downloaded\r")
 }
```

Now, let's look at this file. What do we notice about it? 


All right, let's move on to trying to write a function that will return all IDs for all of the ants.

```{r, include = TRUE, eval = FALSE}

search_year <- function(ant){
    query <- paste0(ant, " AND ", "2018:2019[PDAT]")
    search_returns <- c(entrez_search(db="Nucleotide", term=query, retmax=20,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = T)


```
Have a look at ?sapply. Talk to a partner and see if you can figure out what sapply does. 

So what is the problem with this output? It's hard to parse - let's make it easier to pull data for one taxon at a time.

```{r, include = TRUE, eval = FALSE}

search_year <- function(ant){
    search_returns = c()
    query <- paste0(ant, " AND ", "2018:2019[PDAT]")
    search_returns[ant] <- c(entrez_search(db="Nucleotide", term=query, retmax=20,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = T)

```

There's one remaining problem, though. Have a look at your outputs. How do you think we can fix this one? Let's have a look at when papers related to Xymmer were published:

```{r, include = TRUE, eval = FALSE}
xymmer_papers <- entrez_search(db="pmc", term="Xymmer", retmax=20, rettype= "text", api_key ="96b569c049fe3d3055c5b747112dfec84308")
xymmer_papers <- entrez_fetch(db="pmc", term="Xymmer", id = xymmer_papers$ids, retmax=20, rettype= "text", api_key ="96b569c049fe3d3055c5b747112dfec84308")
```

Does this give you a hint about something that needs to change to get more data? 

```{r, include = TRUE, eval = FALSE}

search_year <- function(ant){
    search_returns = c()
    query <- paste0(ant, " AND ", "2018:2019[PDAT]")
    search_returns[ant] <- c(entrez_search(db="Nucleotide", term=query, retmax=20,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = T)

```

Now, we're going to get the genetc data.

```{r, eval = FALSE}

search_seq <- function(ant){
     recs[ant] <- entrez_fetch(db="nuccore", id = ant,
                          rettype="fasta", retmax=10)
     cat(recs, file="Ants.seqs.fasta", append=TRUE)

  return(recs)
}


seq_returns <- sapply(labels, search_seq,  USE.NAMES = T)


```



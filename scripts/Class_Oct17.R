install.packages("devtools")
devtools::install_github("ropensci/rotl")
devtools::install_github("ropensci/traits")
devtools::install_github(repo='ropensci/phylotaR', build_vignettes=TRUE)

library(rotl)
library(phylotaR)

apes <- c("Pongo", "Pan", "Gorilla", "Hoolock", "Homo")
(resolved_names <- rotl::tnrs_match_names(apes))

ants <- c("Martialis", "Atta", "Ectatomma", "Tatuidris", "Aneuretus", "Xymmer", "Aenictus")
(resolved_names <- rotl::tnrs_match_names(ants))

tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))

plot(tr)



library(rentrez)
entrez_search(db = "Nucleotide", term="Ectatomma", api_key ="96b569c049fe3d3055c5b747112dfec84308")

Ectatomma <- entrez_search(db = "Nucleotide", term="Ectatomma AND 2018:2019[PDAT]", retmax = 100, api_key ="96b569c049fe3d3055c5b747112dfec84308")

for( seq_start in seq(1,50,100)){
  recs <- entrez_fetch(db="nuccore", id = Ectatomma$ids,
                       rettype="fasta", retmax=50)
  cat(recs, file="Ect.seqs.fasta", append=TRUE)
  cat(seq_start+49, "sequences downloaded\r")
}

search_year <- function(ant){
  query <- paste0(ant, " AND ", "2016:2019[PDAT]")
  search_returns <- c(entrez_search(db="Nucleotide", term=query, retmax=20,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = T)

search_year <- function(ant){
  search_returns = c()
  query <- paste0(ant, " AND ", "2016:2019[PDAT]")
  search_returns[ant] <- c(entrez_search(db="Nucleotide", term=query, retmax=20,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = T)

xymmer_papers <- entrez_fetch(db="pmc", term="Xymmer", id = xymmer_papers$ids, retmax=20, rettype= "text", api_key ="96b569c049fe3d3055c5b747112dfec84308")

search_year <- function(ant){
  search_returns = c()
  query <- paste0(ant, " AND ", "HINT HINT HINT:2019[PDAT]")
  search_returns[ant] <- c(entrez_search(db="Nucleotide", term=query, retmax=1,api_key ="96b569c049fe3d3055c5b747112dfec84308"))
  return(search_returns)
}


ants <- as.vector(resolved_names$unique_name)

labels <- sapply(ants,search_year,  USE.NAMES = F)

search_seq <- function(labels){
  recs[ant] <- entrez_fetch(db="nuccore", id = labels,
                            rettype="fasta", retmax=1)
  cat(recs, file="Ants.seqs.fasta", append=TRUE)
  return(recs)
}


seq_returns <- sapply(labels, search_seq,  USE.NAMES = T)

install.packages("ape")

coi <- ape::read.dna("Ants.seqs.fasta", format="fasta")

#zaladowanie bibl
library(tm)

#zmiana katalogu roboczego
workDir <- "D:\\oh\\RJN11S"
setwd(workDir)

#definicja katalogu funkcjonalnego
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspaceDir <- ".\\workspaces"
dir.create(workspaceDir, showWarnings = TRUE)
dir.create(outputDir, showWarnings = TRUE)

#utworzenie korpusu dokumentow
corpusDir <- paste(inputDir, "Literatura", sep = "\\")
corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding = "UTF-8"
    ),
  readerControl = list(
    language = "pl_PL"
  )
)

#wstepne przetwarzanie
transformations = list(PlainTextDocument, stripWhitespace, 
                       removeNumbers, removePunctuation, tolower)
corpus <- tm_map(corpus, tm_reduce, tmFuns=transformations)
stoplistFile <- paste(inputDir, "stopwords_pl.txt", sep = "\\")
stoplist <- readLines(stoplistFile, encoding ="UTF-8")
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)

#wyswietlane zawartosci pojedynczej
writeLines(as.character(corpus[[1]]))
writeLines(corpus[[1]]$content)

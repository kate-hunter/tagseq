library(dplyr)

files <- list.files(path=".", pattern=NULL)
## making a list of data frames with row and column names while removing last five lines from HTSeq that contains the features and ambiguous read infromation
dfList <- lapply(files, function(x) {
  read.csv(x, nrows = length(count.fields(x))-5, sep = "\t", header = F, row.names = 1, col.names = c("genes",tools::file_path_sans_ext(basename(x))))})
## combining all the dataframes into single dataframe
matrix <- bind_cols(dfList)

#change names of rows
names<-gsub("_.*", "", files)
colnames(matrix)<-names


write.csv(matrix, "matrix.csv")

##full table
dfList_last5 <- lapply(files, function(x) {
  read.csv(x, nrows = length(count.fields(x)), sep = "\t", header = F, row.names = 1, col.names = c("genes",tools::file_path_sans_ext(basename(x))))})

## combining all the dataframes into single dataframe
matrix_last5 <- bind_cols(dfList_last5)

tail(matrix_last5, n=5)

#then I want to remove everything but the last 5 rows from the matrix
#change names of rows
names<-gsub("_.*", "", files)
colnames(matrix_last5)<-names

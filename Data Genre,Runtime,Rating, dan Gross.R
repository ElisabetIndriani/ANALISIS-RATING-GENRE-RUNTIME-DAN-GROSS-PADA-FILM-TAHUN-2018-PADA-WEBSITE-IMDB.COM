library(xml2)
library(rvest)

alamat_web<-('https://www.imdb.com/search/title/?count=100&release_date=2018,2018&title_type=feature')

alamatweb<-read_html(alamat_web)

alamatweb

#mencari data runtime
runtime<-html_nodes(alamatweb,'.runtime')
run_time<-html_text(runtime)
head(run_time)

run_time<-gsub("min", "", run_time)
head(run_time)
run_time<-as.numeric(run_time)
head(run_time)

#mencari data genre
genre<-html_nodes(alamatweb,'.genre')
data_genre<-html_text(genre)
head(data_genre)

data_genre<-gsub("\n","", data_genre)
data_genre<-gsub(" ","", data_genre)
data_genre<-gsub(",.*","",data_genre)
head(data_genre)
data_genre<- as.factor(data_genre)
head(data_genre)

#mencari data rating
rating<- html_nodes(alamatweb,'.ratings-imdb-rating strong')
data_rating<- html_text(rating)
head(data_rating)
data_rating<-as.numeric(data_rating)
head(data_rating)

#mencari data gross
gross<-html_nodes(alamatweb,'.ghost~ .text-muted+ span')
data_gross<-html_text(gross)
head(data_gross)
data_gross<-gsub("M","",data_gross)
data_gross<-substring(data_gross,2,6)
head(data_gross)
data_gross<- as.numeric(data_gross)
head(data_gross)
length(data_gross)

#mencari data yang lebih luass
large<-html_nodes(alamatweb,'.sort-num_votes-visible')
large_gross<-html_text(large)
head(large_gross)
length(large_gross)
large_gross<-substring(large_gross,90,100)
large_gross<-gsub("\n","",large_gross)
large_gross<-gsub("M","",large_gross)
large_gross<-gsub(" ","",large_gross)
large_gross<-substring(large_gross,2,6)
head(large_gross)
large_gross<-as.numeric(large_gross)
head(large_gross)
length(large_gross)

#membuat dataframe

data_film <- data.frame(Runtime=run_time,Genre=data_genre,Rating=data_rating,Gross=large_gross)
str(data_film)

#membuat plot
library(ggplot2)
qplot(data=data_film, Runtime, fill=Genre, bins=30)

#membuat plot kedua
p<-ggplot(data=data_film,aes(x=Runtime,y=Gross))
p+geom_point(aes(size=Rating, col=Genre))
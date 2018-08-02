library(rvest)
library(xml2)
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
webpage <- read_html(url)
rank_data_html <- html_nodes(webpage,'.text-primary')
rank_data <- html_text(rank_data_html)
head(rank_data)
rank_data<-as.numeric(rank_data)
head(rank_data)
title_data_html <- html_nodes(webpage,'.lister-item-header a')
title_data <- html_text(title_data_html)
head(title_data)
description_data<-html_nodes(webpage,'.ratings-bar+ .text-muted')
description_data<-html_text(description_data)
head(description_data)
description_data<-gsub("\n","",description_data)
runtime_data<-html_nodes(webpage,'.text-muted .runtime')
runtime_data<-html_text(runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)
runtime_data<-gsub(" min","",runtime_data)
genre_data<-html_nodes(webpage,'.genre')
genre_data<-html_text(genre_data)
head(genre_data)
genre_data<-gsub("\n"," ",genre_data)
genre_data<-gsub(" ","",genre_data)
genre_data<-gsub(",*","",genre_data)
genre_data<-as.factor(genre_data)
ratings_data<-html_nodes(webpage,'.ratings-imdb-rating')
ratings_data<-html_text(ratings_data)
head(ratings_data)
ratings_data<-gsub("\n"," ",ratings_data)
ratings_data<-gsub(" ","",ratings_data)
ratings_data<-as.numeric(ratings_data)
votes_data<-html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
votes_data<-html_text(votes_data)
head(votes_data)
votes_data<-as.numeric(votes_data)
votes_data<-gsub(",","",votes_data)
directors_data<-html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
directors_data<-html_text(directors_data)
head(directors_data)
directors_data<-as.factor(directors_data)
actors_data<-html_nodes(webpage,'.lister-item-content .ghost+ a')
actors_data<-html_text(actors_data)
head(actors_data)
actors_data<-as.factor(actors_data)
metascore_data<-html_nodes(webpage,'.metascore')
metascore_data<-html_text(metascore_data)
head(metascore_data)
metascore_data<-gsub(" ","",metascore_data)
length(metascore_data)
for (i in c(43,65)){
  
  a<-metascore_data[1:(i-1)]
  
  b<-metascore_data[i:length(metascore_data)]
  
  metascore_data<-append(a,list("NA"))
  
  metascore_data<-append(metascore_data,b)
  
}
metascore_data<-as.numeric(metascore_data)
length(metascore_data)
gross_data<-html_nodes(webpage,'.ghost~ .text-muted+ span')
gross_data<-html_text(gross_data)
length(gross_data)
head(gross_data)
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)
for (i in c(5,8,9,43,50,55,61,65,76,92,96)){
       a<-gross_data[1:(i-1)]
       
        b<-gross_data[i:length(gross_data)]
        
          gross_data<-append(a,list("NA"))
           
             gross_data<-append(gross_data,b)
            
}
gross_data<-as.numeric(gross_data)
movie_df<-data.frame(rank=rank_data,title=title_data,description=description_data,grossinmillion=gross_data,actors=actors_data,director=directors_data,runtime=runtime_data,ratings=ratings_data,metascore=metascore_data,genre=genre_data)
str(movie_df)
View(movie_df)

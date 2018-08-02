library(ggplot2)
qplot(data=movie_df,runtime,fill=genre,bins=30)

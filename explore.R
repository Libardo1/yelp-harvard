# Ryan Kerr
# explore-yelp.R
# exploring the academic yelp! dataset

library(jsonlite)

yelp_base <- stream_in(file("data/yelp_academic_dataset.json"))

biz <- yelp_base[yelp_base$type == "business",]

# harvard_mit <- biz[biz$state == "MA",]

harvard = biz[biz$neighborhoods == "Harvard Square",]

plot(biz$review_count, biz$stars)

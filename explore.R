# Ryan Kerr
# explore-yelp.R
# exploring the academic yelp! dataset

library(jsonlite)

yelp_base <- stream_in(file("data/yelp_academic_dataset.json"))

biz <- yelp_base[yelp_base$type == "business",]


# let's look at Harvard/Harvard Square first
harvard = biz[biz$state == "MA" & biz$schools != "University of Massachusetts - Amherst",]

# adding distance from Harvard Square T stop
# these values found by using google maps
harv_lat = 42.373467
harv_long = -71.118972
harvard$distance = sqrt((harv_lat - harvard$latitude)^2 + (harv_long - harvard$longitude)^2)

harv_square = harvard[harvard$neighborhoods == "Harvard Square",]

# ordered by distance
plot(harv_square$distance, harv_square$review_count)
plot(harv_square$review_count, harv_square$stars)
plot(harv_square$distance, harv_square$review_count)

write(toJSON(harv_square), "harv_square.json")


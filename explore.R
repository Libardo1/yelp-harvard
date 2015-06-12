# Ryan Kerr
# explore-yelp.R
# exploring the academic yelp! dataset

library(jsonlite)

yelp_base <- stream_in(file("data/yelp_academic_dataset.json"))

biz <- yelp_base[yelp_base$type == "business",]
usr <- yelp_base[yelp_base$type == "user",]
rev <- yelp_base[yelp_base$type == "review",]


# let's look at Harvard/Harvard Square first
harvard = biz[biz$state == "MA" &
              biz$schools != "University of Massachusetts - Amherst",]

# adding distance from Harvard Square T stop
# these values found by using google maps
harv_lat = 42.373467
harv_long = -71.118972
harvard$distance = sqrt((harv_lat - harvard$latitude)^2 + (harv_long - harvard$longitude)^2)

# find restaurants
rest = function(cell) {
  boo = FALSE
  for(elem in cell[[1]]) {
    if (elem == "Restaurants") {
      boo = TRUE
    }
  }
  boo
}

harvard$restaurant = FALSE
for (row in 1:nrow(harvard)) {
  harvard[row,]$restaurant = rest(harvard[row,]$categories)
}


harv_square = harvard[harvard$neighborhoods == "Harvard Square",]
hsq_rest = harv_square[harv_square$restaurant == TRUE,]

# some exploratoriy plots
plot(harv_square$distance, harv_square$review_count)
plot(harv_square$review_count, harv_square$stars)

plot(hsq_rest$distance, hsq_rest$review_count)
plot(hsq_rest$review_count, hsq_rest$stars)


write(prettify(toJSON(harv_square)), "hsq_rest.json")

# exploring different cuisines
cats <- c("Restaurants")
for (cell in hsq_rest$categories) {
  for (category in cell) {
    print(category %in% cats)
    if ((category %in% cats) == FALSE) {
      cats <- c(cats, category)
    }
  }
}



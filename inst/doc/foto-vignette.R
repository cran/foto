## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# load the library
library(foto)
library(terra)

## ----figure_1, message = FALSE, warning = FALSE, fig.width=7, fig.height=7----
library(foto)
library(terra)

# load demo data
r <- terra::rast(sprintf("%s/extdata/yangambi.png", path.package("foto")))

# classify pixels using zones (discrete steps)
output <- foto(r,
     plot = TRUE,
     window_size = 51,
     method = "zones"
     )

## ----figure_2, fig.width=7, fig.height=7--------------------------------------
# crop the image for speed
r_1 <- terra::crop(r, terra::ext(1,100,1,100))

# crop the image
output_1 <- foto(r_1,
     plot = TRUE,
     window_size = 51,
     method = "mw")

## ----warning=FALSE, message=FALSE---------------------------------------------
# load demo data path
path <- system.file("extdata",package="foto")

# classify pixels using zones (discrete steps)
# across images
output_batch <- foto_batch(path = path,
                window_size = 51,
                method = "zones")

# indiviual images would look different when processed one by one
r_2 <- terra::rast(sprintf("%s/extdata/yangambi_2.png",
                              path.package("foto")))

# classify pixels using zones (discrete steps)
output_2 <- foto(r_2,
     window_size = 51,
     method = "zones")

## ----figure_3, fig.width=7, fig.height=4--------------------------------------
par(mfrow = c(1,2))
plot(r_2, col = grey.colors(100), axes = FALSE, legend = FALSE, box = FALSE)
plot(r, col = grey.colors(100), axes = FALSE, legend = FALSE, box = FALSE)

par(mfrow = c(1,2))
plotRGB(output_batch[[1]], stretch = "hist")
plotRGB(output_batch[[2]], stretch = "hist")

par(mfrow = c(1,2))
plotRGB(output_2$rgb, stretch = "hist")
plotRGB(output$rgb, stretch = "hist")


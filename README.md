# Image Upload for elm 0.19

The code in this repository is taken from a [blog post](https://www.paramander.com/blog/using-ports-to-deal-with-files-in-elm-0-17) written by Tolga Paksoy.

## Run it

    elm make Main.elm Ports.elm --output=elm.js
    elm reactor
    
Go to `http://localhost:8000` and click on `index.html`.

If an image is chosen from the file field, it is displayed on the same page.

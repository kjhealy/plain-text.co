Envisioned CSS
=========
Edward Tufte uses a distinctive style in his handouts: simple, with well-set
typography, extensive sidenotes, and tight integration of graphics and
charts. `envisioned-css` brings that style to HTML documents.

This project is directly inspired by and
based on [tufte-css](https://github.com/daveliepmann/tufte-css), [tablesaw](https://github.com/filamentgroup/tablesaw), [Pushy off-canvas navigation](https://github.com/christophery/pushy) and
[R Markdown Tufte Handout](http://rmarkdown.rstudio.com/examples/tufte-handout.pdf).

Getting Started
-
The file *index.html* is a self-describing demonstration document that walks through
the features of Envisioned CSS. The file *with-nav.html* demos the use of the navigation functionality. The live demos are at the following,
[nogginfuel.com/envisioned-css](http://nogginfuel.com/envisioned-css/) and [nogginfuel.com/envisioned-css/with-nav.html](http://nogginfuel.com/envisioned-css/with-nav.html). They best summarize the project.

To use Envisioned CSS on your own website, just copy `envisioned.css`, `tablesaw-stackonly.css`, `nudge.css`, `Roboto-Regular.ttf`, `RobotoCondensed-Regular.ttf` and `RobotoMono-Regular.ttf` to your project
directory (or just copy the folder structure) and add the following to your HTML doc's head block:

```html
<link rel="stylesheet" href="css/envisioned.css"/>
<link rel="stylesheet" href="css/tablesaw-stackonly.css"/>
<link rel="stylesheet" href="css/nudge.css"/> <!-- if you want navigation -->

```

You will also need to copy `jquery.js`, `tablesaw-stackonly.js` and `nudge.min.js` (or the folder structure) add the following block prior to the closing `</body>` tag:

```html
<script src="js/jquery.js"></script>
<script src="js/tablesaw-stackonly.js"></script>
<script src="js/nudge.min.js"></script> <!-- if you want navigation -->

```

Contributing
-
If you notice something wrong or broken, please open an
issue. **Pull requests are very welcome**.

For best results, keep pull requests to one change at a time, and
test your fix or new functionality against `index.html` on screens as
small as smart phones and as big as HD or HD+ displays. If you don't have a mobile device handy, fake different devices with your browser's developer tools.


Inspiration
-
 - [Dave Liepmann - Tufte CSS](https://github.com/daveliepmann/tufte-css)
 - [Filament Group - Tablesaw](https://github.com/filamentgroup/tablesaw)
 - [Christopher Yee - Pushy](https://github.com/christophery/pushy)


License
-
The code is Released under the MIT license. *LICENSE.MD*.
The Roboto fonts are subject to the Apache 2.0 in the following directory font > Roboto folder > *LICENSE.TXT*.
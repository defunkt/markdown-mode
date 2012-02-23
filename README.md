Emacs markdown-mode with ikiwiki functionality
===============================================

This fork implements [ikiwiki]-specific behaviour in markdown-mode.

[ikiwiki]:http://ikiwiki.info

It uses a minor-mode and specific functions.

## Features ##

* an emacs-browser for the ikiwiki
* correct handling of ikiwiki-directives
* previewing in web-browser

## Usage

* set the variables for your ikiwiki instance, e.g.

    (setq ikiwiki-setup-file "/home/ihrke/work/admin/conf/iki.setup")
    (setq ikiwiki-toplevel "/home/ihrke/work/iki/")
    (setq ikiwiki-browse-extensions '("mdwn" "markdown"))

* run ikiwiki-mode when editing a markdown-file

## Author

Matthias Ihrke <ihrke@nld.ds.mpg.de>

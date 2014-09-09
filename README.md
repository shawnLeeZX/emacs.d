# Configuration for emacs
I forked this [emacs.d](https://github.com/purcell/emacs.d) to make my own.

You could setup your own following the tutorial
[here](http://shawnleezx.github.io/blog/2014/08/18/learning-emacs-in-3-days/).

Continuing the tutorial, functionalities added after forking of this `emacs.d`
will be described.

If you find this repo useful, please give it a star!

## General Extensions

### Package Management

Emacs has better package management mechanism for extensions than
vim. I use `package.el`. See this
[blog](http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/).

Note that this is not an added functionalities.

### Copy Paste
I use emacs in a termial, and by default inter-program copy and paste
does not work.

This
[blog](http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/)
talks about how copy and paste works in emacs, or more generally under linux.

To enable inter-program copy and paste, see this
[blog](http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/).

### Swap Ctrl and Caps Lock
Make `<Caps Lock>` a `<Ctrl>` key to speed up typing. See
[here](http://www.emacswiki.org/emacs/MovingTheCtrlKey).

### Manage Extra with git
Occasionally, you cannot find extensions you want in the package
management system. To manage the extensions you download, use git. And
to keep those extensions in their git repo will ease the process of
updating. To make this work, some knowledge of git submodule will be
helpful. See this [post](http://longair.net/blog/2010/06/02/git-submodules-explained/).

### Display a visual fill column indicator

```lisp
;; Display a visual indicator for fill column width.
(require 'fill-column-indicator)
(define-global-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
```

### Autopair

Beyond the electric-pair mode used in purcell's configuration, I use
[autopair](https://github.com/capitaomorte/autopair) to make the auto
pairing more functional.

### ECB

[ECB](http://ecb.sourceforge.net/) stands for "Emacs Code Browser". While Emacs
already has good editing support for many modes, its browsing support is
somewhat lacking. That's where ECB comes in: it displays a number of
informational windows that allow for easy source code navigation and overview.

Regardless of the languages, ECB provides its functionalities.

### Projectile

[Projectile](https://github.com/bbatsov/projectile) provides easy
project management and navigation. The concept of a project is pretty
basic - just a folder containing special file. Currently `git`,
`mercurial`, `darcs` and `bazaar` repos are considered projects by
default. So are `lein`, `maven`, `sbt`, `scons`, `rebar` and `bundler`
projects.

### Evil -- combine the best of emacs and vim.

If you are also a vimmer try [evil](http://www.emacswiki.org/emacs/Evil).

If you want to speed up your development, also try it!

If you are using emacs under screen or tmux, change the timeout to
make evil works smoothly.

For tmux, change `.tmux.conf`:

```bash
tmux set -sg escape-time 0
```
For screen, change `.screenrc`

```bash
maptimeout 5
```
### Magit

[magit](https://github.com/magit/magit) is a git extension for
integrating git with emacs. The default works well. However, the
highlight current line feature is pretty annoying because it will make
it hard to see the actual code while diffing. The following code will
disable highlighting.

```lisp
;; Make magit do not hightligh the line where the cursor is, since it
;; will make the diff code unclear.
(defface magit-item-highlight
  '((t :inherit background))
  "Face for highlighting the current item."
  :group 'magit-faces)
```

## IDE for C/C++

Below is three video on Youtude.

* [Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and autoplete](https://www.youtube.com/watch?v=HTUE03LnaXA)
* [Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint, google-c-style](https://www.youtube.com/watch?v=r_HW0EB67eY)
* [Emacs as a C/C++ Editor/IDE (Part 3): Installing CEDET mode for true intellisense](https://www.youtube.com/watch?v=Ib914gNr0ys)

## IDE for Python

### Jedi

[Jedi.el](https://github.com/tkf/emacs-jedi) is a Python
auto-completion package for Emacs. It aims at helping your Python
coding in a non-destructive way. It also helps you to find information
about Python objects, such as docstring, function arguments and code
location.

Note that it use auto-complete extension as its auto completion
interface,  not replace it as seems in the first sight.

Jedi need some configuration to work well, for instance, including
code of your project. See code for more info.

I am also trying to use robemacs to do code completion and
refactoring, but the setting up process is just too annoy which makes
me realize why Jedi exists -- to remove the need for external tools.

### Flycheck

To make flycheck work with python, `pylint` needs to be installed:

```bash
sudo pip install pylint
```

## IDE for R.
[Emacs Speaks Statistics (ESS)](http://ess.r-project.org/) is an
add-on package for emacs text editors such as GNU Emacs and XEmacs.It
is designed to support editing of scripts and interaction with various
statistical analysis programs such as R, S-Plus, SAS, Stata and JAGS.

ESS works with auto-complete to provide auto completion.
[Link](http://www.emacswiki.org/emacs/ESSAuto-complete). Note that you should
start R, using `M-X R` beforehand, to make the autocomplete work.

## IDE for ruby on rails

### yari

[yari](http://www.emacswiki.org/emacs-de/YARI) provides an Emacs frontend to Ruby's `ri` documentation tool. It offers
lookup and completion.

### robe

[Robe](https://github.com/dgutov/robe) is a code assistance tool that uses a Ruby REPL subprocess with your
application or gem code loaded, to provide information about loaded classes and
modules, and where each method is defined.

### inf-ruby
[inf-ruby](https://github.com/nonsequitur/inf-ruby/) provides a REPL buffer connected to a Ruby subprocess.

### web-mode with auto-complete

[web-mode.el](http://web-mode.org/) is an autonomous emacs major-mode for
editing web templates: HTML documents embedding parts (CSS / JavaScript) and
blocks (client / server side). I added context awareness in web-mode to let
auto-complete to make it capable of working with all kinds of language in the
embedded file. What's more, web-mode is able to autoclose html tag pairs.

### flycheck

To enable flycheck for ruby, install:

```bash
gem install rubocop ruby-lint
```

TODO: make flycheck for `.erb` files work.

## IDE for Javascript

Tweak purcell's config letting it only suit with emacs 24+.

[js2-mode](https://code.google.com/p/js2-mode/): An improved JavaScript
mode for GNU Emacs.

[ac-js2](https://github.com/ScottyB/ac-js2): An attempt at context
sensitive auto-completion for Javascript in Emacs using js2-mode's
parser and Skewer-mode (requires Emacs 24.3).

[coffee-mode](https://github.com/defunkt/coffee-mode): An Emacs major
mode for CoffeeScript and IcedCoffeeScript.

[skewer-mode](https://github.com/skeeto/skewer-mode): Provides live
interaction with JavaScript, CSS, and HTML in a web
browser. Expressions are sent on-the-fly from an editing buffer to be
evaluated in the browser, just like Emacs does with an inferior Lisp
process in Lisp modes. Call `run-skewer` to start server in the brower
to enable its functionalities.

## Utilities

A bunch of utilities for ease of usage is added in
`local-lisp/init/init-local.el`. See the comment in the file for detail.

### Highlighting indentation
[Highlight indentation](https://github.com/antonj/Highlight-Indentation-for-Emacs) for emacs.


## Misc

* Generate tags for emacs using `-e` option using ctags.
* Shell in emacs. See this [post](http://www.masteringemacs.org/articles/2010/11/01/running-shells-in-emacs-overview/).
* I recommend a product called
  [teambition](https://www.teambition.com/) to replace the org-mode to
  GET THINGS DONE. Its has a web interface and app on smartphone.


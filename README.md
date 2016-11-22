# Configuration for Emacs

I switched from Vim to Emacs (and still use Vim for quick editing, especially
tasks in servers). So this may be a good guide for Vimers who want to try out Emacs.

## General Extensions

### Package Management

Emacs has better package management mechanism for extensions than vim. I use
`package.el`, which is built-in in Emacs. See this
[blog](http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/)
for an introduction.

### Auto-complete & Company

[company](http://company-mode.github.io/) and
[auto-complete](https://github.com/auto-complete/auto-complete) are the two
frameworks of Emacs to provide automatically completion
functionality. `auto-complete` does good when you are writing text heavy
contents such as LaTeX or markdown while `company` does well on logically heavy
ones such as programming language.

This emacs configuration uses both the two to provide a better editing
environment. For a partial comparison between the two and how to use them
together, refer to this
[note](http://shawnleezx.github.io/blog/2015/08/11/on-auto-completion-in-emacs/).

### Yasnippet

[YASnippet](https://github.com/capitaomorte/yasnippet) is a template system for
Emacs. It allows you to type an abbreviation and automatically expand it into
function templates. Bundled language templates include: C, C++, C#, Perl,
Python, Ruby, SQL, LaTeX, HTML, CSS and more.

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

### Auto header insertion

[header2.el](http://www.emacswiki.org/emacs/header2.el) is used to automatically
create file headers.

Notice that you need to manually add your contact in the header by changing the
source code. I decided to work this way ...

### Smartparens

[Smartparens](https://github.com/Fuco1/smartparens/wiki) is minor mode for
Emacs that deals with parens pairs and tries to be smart about it. It started
as a unification effort to combine functionality of several existing packages
in a single, compatible and extensible way to deal with parentheses,
delimiters, tags and the like. Some of these packages include autopair,
textmate, wrap-region, electric-pair-mode, paredit and others.

Smartparens has support for LaTeX and python, to use it add the following
lines to your latex and python configuration respectively:

```lisp
(require 'smartparens-latex)
```

```lisp
(require 'smartparens-python)
```

What's more if you write math in markdown often, there is one trick to make the
support of smartparens to work with `markdown-mode` as well. Find the following
line in `smartparens-latex`:

```lisp
(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
                 )
```

and add `markdown-mode` in

```lisp
(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
                 markdown-mode
                 )
```

For paredit user, here is a
[comparison](https://github.com/Fuco1/smartparens/wiki/Paredit-and-smartparens)
between paredit and smartparens.

Note that `redshank` uses paredit which conflicts with smartparens.

### ECB

[ECB](http://ecb.sourceforge.net/) stands for "Emacs Code Browser". While Emacs
already has good editing support for many modes, its browsing support is
somewhat lacking. That's where ECB comes in: it displays a number of
informational windows that allow for easy source code navigation and overview.

Regardless of the languages, ECB provides its functionalities.

However, the file and directory browsing functionality of ECB is really
unusable. Recently, [neotree](https://github.com/jaypei/emacs-neotree), a emacs
tree plugin like NerdTree for Vim, fills this gap. Many of its tips could be
found on its [wiki](http://www.emacswiki.org/emacs/NeoTree).

### Projectile

[Projectile](https://github.com/bbatsov/projectile) provides easy
project management and navigation. The concept of a project is pretty
basic - just a folder containing special file. Currently `git`,
`mercurial`, `darcs` and `bazaar` repos are considered projects by
default. So are `lein`, `maven`, `sbt`, `scons`, `rebar` and `bundler`
projects.a

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

### Code Completion
[irony-mode](https://github.com/Sarcasm/irony-mode) is an Emacs minor-mode that
aims at improving the editing experience for the C, C++ and Objective-C
languages. It works by using a combination of an Emacs package and a C++
program (`irony-server`) that uses
[libclang](http://clang.llvm.org/doxygen/group__CINDEX.html).

It is very fast and accurate except for the incapability to deal with
templates, which solves the problem that [CEDET](http://cedet.sourceforge.net/)
could not handle large projects.

For trouble shooting while using it, may refer to my
[note](http://shawnleezx.github.io/blog/2015/08/11/on-code-completion-for-c-slash-c-plus-plus/).

### Code Navigation

[ggtags](https://github.com/leoliu/ggtags) is the Emacs frontend to GNU Global
source code tagging system, which provides a lot of features to aid code
navigation.

### Error Checking & Style Enforcement

Uses
[flymake-google-cpplint](https://github.com/senda-akiha/flymake-google-cpplint),
[flycheck](https://github.com/flycheck/flycheck) and
[google-c-style](https://google-styleguide.googlecode.com/svn/trunk/google-c-style.el).

### Header File Completion

Uses
[company-c-headers](https://github.com/randomphrase/company-c-headers). This
library enables the completion of C/C++ header file names using Company mode
for Emacs.

### Function Documentation Display
Use [irony-eldoc](https://github.com/ikirill/irony-eldoc). This implements
eldoc support in irony-mode. eldoc is a built-in Emacs mode for displaying
documentation about a symbol or function call at point in the message buffer
(see eldoc-mode).

## IDE for Python

### elpy

[Elpy](https://github.com/jorgenschaefer/elpy) is an Emacs package to bring
powerful Python editing to Emacs. It combines a number of other packages, both
written in Emacs Lisp as well as Python.

It is surprising easy to set up. One thing to note is that I have trouble using
`rope` as the backend for elpy, which cannot handle cross module
navigation. Instead, I used `jedi`.

### Flycheck

Though elpy uses the build-in `flymake` to provide syntax checking. `flycheck`
is also enabled, mostly for not bothering to disable flycheck specifically for
just python, though these two checkers has been configured to use `pyflakes` to
syntax checking.

To make flycheck work with python, `pyflakes` needs to be installed:

```bash
sudo pip install pyflakes
```

Previously, I used `flake8`, but later found I need to break indentation rule
of PEP8 from time to time. Before that, I used `pylint`, however, it makes a
bunch of error when dealing with external python library.

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

## IDE for Javascript

[js2-mode](https://code.google.com/p/js2-mode/): An improved JavaScript
mode for GNU Emacs.

[ac-js2](https://github.com/ScottyB/ac-js2): An attempt at context
sensitive auto-completion for Javascript in Emacs using js2-mode's
parser and Skewer-mode (requires Emacs 24.3).

[coffee-mode](https://github.com/defunkt/coffee-mode): An Emacs major
mode for CoffeeScript and IcedCoffeeScript.

[skewer-mode](https://github.com/skeeto/skewer-mode): Provides live interaction
with JavaScript, CSS, and HTML in a web browser. Expressions are sent
on-the-fly from an editing buffer to be evaluated in the browser, just like
Emacs does with an inferior Lisp process in Lisp modes. In `skewer-mode`, Emacs
maintains a web server so we do not need to set up a server using `python -m
SimpleHTTPServer 8888` or other servers. Run `httpd-serve-directory` to select
the root directory and start the server. The port number is `8080`. You need to
include `<script src="http://localhost:8080/skewer"></script>` in the main HTML
file to make it work.

## IDE for Octave.

Octave has support for emacs, which is pretty great. It will do real
auto completion and all sorts of other things.

*NOTE*

I am using emacs 24.3, of which octave integration is buggy. If your
emacs version is less than 24.4 as me:

since I use ac-octave from elpa and code of ac-otave is not included
in the git repo, you need to change source in elpa/ac-octave to make
sure the repo works. More specifically, ac-octave will check your
version number and if it is less than 24.4, it will try to include
octave-inf.el. Disable the version check and always try to load the
new octave.el.


## IDE for LaTeX

The following packages are included:

* [auctex and preview-latex](http://www.gnu.org/software/auctex/), an
  extensible package for writing, formatting and previewing TEX files,
  is set up fully functional, which includes multiple files awareness,
  on the fly error checking, outline minor mode, Math symbol display,
  bundling with auto completion and more small tweak.
* [RefTEX](http://www.gnu.org/software/auctex/reftex.html), a
  specialized package for support of labels, references, citations,
  and the indices in LATEX.
* [latex-pretty-symbols](https://bitbucket.org/mortiferus/latex-pretty-symbols.el/),
  an extension that makes emacs display unicode characters instead of
  latex commands for a lot of the most usual symbols.
* [company-math](https://github.com/vspinu/company-math) Completion back-ends
  for for math unicode symbols and latex tags. It works with
  `autocomplete-mode` --- completion will pop up automatically, so if you press
  `tab` you still could get normal text completion function from
  `autocomplete-mode`.

## Writing Markdown.

See this
[post](http://shawnleezx.github.io/blog/2014/09/24/writing-markdown-with-autocomplete-and-math-equation-in-emacs/).

## IDE for ruby on rails

TODO: support for ruby is not fully tested.

### yari

[yari](http://www.emacswiki.org/emacs-de/YARI) provides an Emacs frontend to
Ruby's `ri` documentation tool. It offers lookup and completion.

### robe

[Robe](https://github.com/dgutov/robe) is a code assistance tool that uses a
Ruby REPL subprocess with your application or gem code loaded, to provide
information about loaded classes and modules, and where each method is defined.

### inf-ruby

[inf-ruby](https://github.com/nonsequitur/inf-ruby/) provides a REPL buffer
connected to a Ruby subprocess.

### web-mode with auto-complete

[web-mode.el](http://web-mode.org/) is an autonomous emacs major-mode for
editing web templates: HTML documents embedding parts (CSS / JavaScript) and
blocks (client / server side). I added context awareness in web-mode to let
auto-complete to make it capable of working with all kinds of language in the
embedded file. What's more, web-mode is able to autoclose html tag pairs.

TODO: `web-mode` needs some more working to work smoothly, unused for now.

### flycheck

To enable flycheck for ruby, install:

```bash
gem install rubocop ruby-lint
```

TODO: make flycheck for `.erb` files work.

## Note on fly-check and fly-make

`fly-check` is said to be a replacement of `fly-maker`. See
[here](http://www.flycheck.org/en/latest/user/flycheck-versus-flymake.html) and
[here](https://www.masteringemacs.org/article/spotlight-flycheck-a-flymake-replacement)
but I enable both of them anyway.

## Utilities

A bunch of utilities for ease of usage is added in
`local-lisp/init/init-local.el`. See the comment in the file for detail.

### Highlighting indentation
[Highlight indentation](https://github.com/antonj/Highlight-Indentation-for-Emacs) for emacs.


## Misc

* Generate tags for emacs using `-e` option using ctags.
* Shell in emacs. See this [post](http://www.masteringemacs.org/articles/2010/11/01/running-shells-in-emacs-overview/).

# Learning Emacs in 3 Days
I forked this [emacs.d](https://github.com/purcell/emacs.d) to make my own.

You could setup your own following the tutorial
[here](http://shawnleezx.github.io/blog/2014/08/18/learning-emacs-in-3-days/).

Continuing the tutorial, functionalities of this `emacs.d` will be described.

## Package Management

Emacs has better package management mechanism for extensions than
vim. I use `package.el`. See this
[blog](http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/).

## Copy Paste
I use emacs in a termial, and by default inter-program copy and paste
does not work.

This
[blog](http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/)
talks about how copy and paste works in emacs, or more generally under linux.

To enable inter-program copy and paste, see this
[blog](http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/).

## Swap Ctrl and Caps Lock
Make `<Caps Lock>` a `<Ctrl>` key to speed up typing. See
[here](http://www.emacswiki.org/emacs/MovingTheCtrlKey).

## Manage Extra with git
Occasionally, you cannot find extensions you want in the package
management system. To manage the extensions you download, use git. And
to keep those extensions in their git repo will ease the process of
updating. To make this work, some knowledge of git submodule will be
helpful. See this [post](http://longair.net/blog/2010/06/02/git-submodules-explained/).

## Development Environment for C/C++

Below is three video on Youtude.

* [Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and autoplete](https://www.youtube.com/watch?v=HTUE03LnaXA)
* [Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint, google-c-style](https://www.youtube.com/watch?v=r_HW0EB67eY)
* [Emacs as a C/C++ Editor/IDE (Part 3): Installing CEDET mode for true intellisense](https://www.youtube.com/watch?v=Ib914gNr0ys)

## Evil

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

## Utilities

A bunch of utilities for ease of usage is added in
`local-lisp/init/init-local.el`. See the comment in the file for detail.

#### Misc

* Generate tags for emacs using `-e` option using ctags.
* Shell in emacs. See this [post](http://www.masteringemacs.org/articles/2010/11/01/running-shells-in-emacs-overview/).
* I recommend a product called
  [teambition](https://www.teambition.com/) to replace the org-mode to
  GET THINGS DONE. Its has a web interface and app on smartphone.

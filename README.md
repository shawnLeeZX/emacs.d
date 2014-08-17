# Learning Emacs in 3 Days
I forked this [emacs.d](https://github.com/purcell/emacs.d) to make my own.

You could setup your own following the tutorial below, which is from [here](http://shawnleezx.github.io/blog/2014/08/18/learning-emacs-in-3-days/).

I am learning and setting up emacs environment in the last three
days. Though various blogs, tutorials and manuals have already talking
about this topic, I did not find one direct path that I can follow to
fulfill my need, which is to learn emacs from zero knowledge, well
organize and set up a satisfactory development IDE.  This blog notes
down what I have done.

## Why Learning Emacs

I am an experienced vimer. Why bother learning another complicated
editor?

Three days ago, I have no idea about the comparison between vim and
emacs, since vim fulfills all my programming tasks -- I have
satisfactory configuration in vim for C/C++, Java, Python, LaTeX,
Markdown, XML, HTML, Octave, Ant, Arduino. You can find my
configuration [here](https://github.com/shawnLeeZX/.vim).

Three days ago, for me, emacs is just an editor that is comparable
with vim, but they cannot win over each other. People stick with emacs
will not get their hand dirdy on vim and vice versa.

There must be something that makes me to spend the next three days
learning emacs.

The story started with a trip on the train. That time, I was reading a
book called *Hacker and Painter*. If you have not read the book, I
strongly recommend it to you. Although this may not be the most
shinning point in the boo, the author succeeded a startup and beat
their competitor largely by using lisp as their programming language
. Before then, I knew lisp is a programming language for AI, a area
where I dedicated myself to work on. But I cannot find any books or
applications use lisp or talk about lisp. It makes me think lisp is
outdated. Afterall, it was proposed by McCarthy tens of years
ago. Such evidence strongly supported the point the author made in the
book that lisp is a language worth learning.

It remains me of an
[article](http://www.catb.org/esr/faqs/hacker-howto.html) about HOW-DO
become a hacker read long time ago. The author writes:

> LISP is worth learning for a different reason — the profound
> enlightenment experience you will have when you finally get it. That
> experience will make you a better programmer for the rest of your
> days, even if you never actually use LISP itself a lot.

This [article](http://www.defmacro.org/ramblings/lisp.html) gives a
nice explanation on lisp.

Therefore, to find the enlightment mentioned by all the hackers, why
from c, python to ruby, their syntax are more and more similar to lisp and
figure out why lisp is created by McCarthy to be the AI language, I
decided to learn lisp. Since emacs lisp is the only place I knew now
uses lisp a lot, I decided to learn emacs.

That's enough about the motivation.

## Comparison Between Vim and Emacs
I would't bother to read such section in other article when I was
using vim exclusively, but I should put some insight into the
advantages and disadvantages the two most powerful editors in the
world.

A simple answer is vim is quicker than any other editor in the world,
including emacs, while more powerful than any other editor in the
world, excluding emacs.

If you push typing speed to the extreme speed, vim, a multi-modal
editor is definitely quicker than emacs. But the coming of
[evil](https://gitorious.org/evil/pages/Home), a plugin to simulate
vim behavior in emacs solves this problem. Actually I am using
evil-mode under emacs. So this evidence does not support the argument.

The real problem is that emacs loads really slow. I have 25M
configuration file for vim, which it only takes less than one second
to load while emacs will normally takes 10 seconds now, no to take
into account that I am just starting using emacs and I will add more
extensions now and then recently. Such a long loading time makes emacs
not suitable for small task. For example, I won't edit config files
under emacs -- I won't even take 10 seconds to edit the file.

However, any serious programming task is not a small task. This is
where emacs stands out, since modern computer are more and more
advanced, which makes the huge volume of emacs not matter.

For non-trivial task, emacs surpasses vim. Emacs has better
autocomplete, syntax highlighting. Emacs is more robust. I will skip
the detail for now.

## Learning Emacs From Zero in 3 Days

I will not pretend smart. I can make emacs work well in three days is
because I spent most of the three days learning and configuring emacs
and I know what I am looking for since I have similar functionalities
in vim. Learning emacs and vim is about learning how compiler find c
header files, auto pairing of parenthesis and more are done. It is
about learning how the underlying is working. That's where the time
is spent.

The following are step-by-step instructions about how to learn emacs
with zero knowledge about emacs. Let's get started.


### Learning Emacs Basics

* Install emacs.
* Open emacs.
* Learning emacs basics.
  * Press `<C-h>t` to invoke the learning-by-doing tutorial. This
  tutorial teaches you basics about emacs.
* Learning how to use the help system.
  * Press `<C-h>r` to open emacs manual in info mode.
  * Press `d` to go to the root of info help system.
  * Find a menu item called `Info`, which is nearly at the bottom of the
    manual.
  * Learning how to use info system in the manual.
  * Now you are capable to basic command of emacs and info.
  * Press `<C-h><C-h>` and check some variables, functions and command
    you do not know what they are for to practice using the help
    system of emacs.
* Learning how to customize emacs.
  * Go to the root of the info manual again.
  * Find a section called `Emacs Lisp Intro`.
  * Enter it.
  * Find a section called `Emacs Initialization`. It will tell you the
    basics about customizing emacs.
* Now you have finished learning basics of emacs and are capable of
  building your customized emacs. There are two manual at the root of
  the info manual, `Emacs Lisp Intro` and `Elisp`. We have used the
  former. The latter is emacs lisp manual. Remember to refer to it to
  learn about lisp when you are customizing your emacs.

### Start With Professional's Emacs.d

To get started, you'd better begin by mimicking others. I started by
forking purcell's [emacs.d](https://github.com/purcell/emacs.d). There are
others as well, such as
[Emacs24 Starter Kit](http://eschulte.github.io/emacs24-starter-kit/). You
are free to choose yours. But one thing is worth pointing out is that
purcell's emacs.d really gives powerful starting. You could also start from this
one, but it needs install extra program, such as xsel and cpplint to let all
features work.

Read its sources to figure out how the extensions are organized and
know how to add your own customization. In the following I will
describe the changes I made up to now.

#### Package Management
Emacs has better package management mechanism for extensions than
vim. I use `package.el`. See this [blog](http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/).

#### Copy Paste
I use emacs in a termial, and by default inter-program copy and paste
does not work.

This
[blog](http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/)
talks about how copy and paste works in emacs, or more generally under linux.

To enable inter-program copy and paste, see this [blog](http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/).

#### Swap Ctrl and Caps Lock
Make `<Caps Lock>` a `<Ctrl>` key to speed up typing. See [here](http://www.emacswiki.org/emacs/MovingTheCtrlKey).

#### Manage Extra with git
Occasionally, you cannot find extensions you want in the package
management system. To manage the extensions you download, use git. And
to keep those extensions in their git repo will ease the process of
updating. To make this work, some knowledge of git submodule will be
helpful. See this [post](http://longair.net/blog/2010/06/02/git-submodules-explained/).

#### Beginning By Setting Up Development Environment for C/C++

Below is three video on Youtude.

* [Emacs as a C/C++ Editor/IDE (Part I): auto-complete, yasnippet, and autoplete](https://www.youtube.com/watch?v=HTUE03LnaXA)
* [Emacs as a C/C++ Editor/IDE (Part 2): iedit, flymake-google-cpplint, google-c-style](https://www.youtube.com/watch?v=r_HW0EB67eY)
* [Emacs as a C/C++ Editor/IDE (Part 3): Installing CEDET mode for true intellisense](https://www.youtube.com/watch?v=Ib914gNr0ys)

#### Evil

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

#### Misc

* Generate tags for emacs using `-e` option using ctags.
* Shell in emacs. See this [post](http://www.masteringemacs.org/articles/2010/11/01/running-shells-in-emacs-overview/).
* I recommend a product called
  [teambition](https://www.teambition.com/) to replace the org-mode to
  GET THINGS DONE. Its has a web interface and app on smartphone.
* Lastly, you can find my `emacs.d` [here](https://github.com/shawnLeeZX/emacs.d).


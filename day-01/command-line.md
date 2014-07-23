---
layout: lesson
root: ../..
title: Introduction to Unix and the command line
author: "Matt Jones"
date: "July 21, 2014"
output: ioslides_presentation
---

## The Command Line

![Command Line](images/isis-bash.png)

## The operating system

![OS Diagram](images/OSDiagram.png
    "https://raw.github.com/ReturnInfinity/BareMetal-OS/master/docs/images/OS%20Diagram%20-%20Standard.png")

![OSes](images/OSes.png
    "http://www.instablogsimages.com/1/2011/08/16/operating_system_wcy2f.png")

## All about the X

![UNIX logo](images/40years.png
    "http://www.unix.org/40years.png")

UNIX
 :  Originally developed at AT&T Bell Labs circa 1970. Has
     experienced a [contentious, fractured
     evolution](https://upload.wikimedia.org/wikipedia/commons/7/77/Unix_history-simple.svg)
POSIX
 :  think of this as a set of specifications of what an OS needs to qualify as "a Unix"


## All about the X

![The unix family tree](images/400px-Unix_history.svg.png
    "http://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Unix_history.svg/1000px-Unix_history.svg.png")

* OS X
 :  [is a Unix](http://unix.stackexchange.com/questions/1489/is-mac-os-x-unix)!
* Linux
 :  is _not_ fully POSIX-compliant, but certainly can be
      regarded as [functionally Unix](http://en.wikipedia.org/wiki/Unix-like)

## Some Unix hallmarks

![Dilbert cartoon](images/dilbert-unix.png
    "http://eikonal.files.wordpress.com/2010/02/dilbert-unix.png")

* Multi-user, multi-process
* Separation of engine from interface
* Small tools for specific jobs
* Culture of text files and streams

## The Command Line

![Screenshot of SQL DB Browser GUI](images/SQLite_Cmd_GUI_Compare.png
    "http://media.getspatial.com/wordpress/SQLite_Cmd_GUI_Compare.png")

GUI
 :  Graphical user interface
CLI
 :  Command-line interface
 
## GUIs can be impressive

![Screenshot of SQL DB browser](images/oz-wizard.png
    "http://thefilmspectrum.com/wp-content/uploads/2011/12/Picture-31.png")

#### [Pay no attention to that man behind the curtain](http://www.youtube.com/watch?v=YWyCCJ6B2WE)

# CLIs let you get things done

![Wizard of Oz](images/oz-man.jpg
    "http://farm7.staticflickr.com/6012/5958643658_0597586c9e_z.jpg")


## Why the CLI is worth learning

* Typically much more extensive access to features, commands, options
* Command statements can be written down, saved (scripts!)
* Easier automation
* Much "cheaper" to do work on a remote system (no need to
      transmit all the graphical stuff over the network)

## Let's connect

![ssh command line screenshot](images/isis-ssh.png)

## Lay of the land

![The directory hierarchy](images/f778-1.gif
    "http://www.informatics.buzdo.com/p778_debian_root_boot_bin_lib_dev.htm")

### Navigating and managing files/directories

* `pwd`, `ls`, `cd`
* `~`, `.`, `..`
* `mkdir`, `cp`, `mv`
* `rm`, `rmdir`

## Permissions

![File permissions](images/UnixFileLongFormat.png
"https://www3.ntu.edu.sg/home/ehchua/programming/howto/images/UnixFileLongFormat.png")

### All files have permissions and ownership

* Change permissions: `chmod`
* Change ownership: `chown`

## Elevate your permissions

![Act as root](images/sandwich.png "http://imgs.xkcd.com/comics/sandwich.png")

## Getting help

![I will ask for help before my problems get out of control](images/asking-for-help.jpg
    "http://www.socialconfidencecenter.com/wp-content/uploads/2012/11/asking-for-help.jpg")  

* `<command> -h`, `<command> --help`
* `man`, `info`, `apropos`, `whereis`
* Search the web!

## General command syntax

* `$ command [options] [arguments]`

### where `command` must be an _executable_ file on your `PATH`
* `echo $PATH`

### and `options` can usually take two forms
* short form: `-h`
* long form: `--help`

<!--
```bash
$ sudo vi /etc/postgresql/9.1/main/postgresql.conf
```
-->

## Text editing

### (Text rules!)

### Some editors

* `vim`
* `emacs`
* `nano`

### `$ nano .bashrc`

## Let's look at our text file

* `cat` print file(s)
* `head` print first few lines of file(s)
* `tail` print last few lines of file(s)
* `less` "pager" -- view file interactively
  

## A sampling of simple commands

* `wc` count lines, words, and/or characters
* `diff` compare two files for differences
* `sort` sort lines in a file
* `uniq` report or filter out repeated lines in a file

## Get into the flow, with pipes 

![`stdin`, `stdout`, `stderr`](images/pipe_split.png
    "http://www.ucblueash.edu/thomas/Intro_Unix_Text/Images/pipe_split.png")

```bash
$ ls *.jpg | wc -l
$ ls *.jpg | wc -l > jpegcount.txt
$ diff <(sort file1.txt) <(sort file2.txt)
$ ls foo 2>/dev/null
$ tee
```

## A sampling of more advanced utilities

* `grep` search files for text
* `sed` filter and transform text
* `find` advanced search for files/directories

## grep

![The file pattern searcher](images/needle_in_a_haystack-300x223.jpg
   "http://ubuntuservergui.com/wp-content/uploads/2011/04/needle_in_a_haystack-300x223.jpg")

## grep

### Show all lines containing "bug" in my R scripts

```bash
$ grep bug *.R
```

### Now count the number of occurrences per file

```bash
$ grep -c bug *.R
```

### Print the names of files that contain bug

```bash
$ grep -l bug *.R
```

### Print the lines of files that __don't__ contain bug

```bash
$ grep -v bug *.R
```

## sed

![The high tech filter](images/chromeblack-faucet-filter.jpg
  "http://www.greenliness.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/c/h/chromeblack-faucet-filter.jpg")

## sed

### Remove all lines containing "bug"!

```bash
$ sed '/bug/d' myscript.R
```

### Call them buglets, not bugs!

```bash
$ sed 's/bug/buglet/g' myscript.R
```

### Actually, only do this on lines starting with #

```bash
$ sed '/#/ s/bug/buglet/g' myscript.R
```


## find

![Search for stuff](images/rover.gif
  "http://4.bp.blogspot.com/_jTQNmLGBIFU/RwZN0Kv3ZYI/AAAAAAAAAvI/ubSNKrTgpms/s400/rover.gif")

### Like Rover, the Windows search dog. But more useful.

## find

### Show me my pdfs!

```bash
$ find . -iname '*.pdf'
```

### Which files are larger than 10GB?

```bash
$ find . -size +10G -ls
```

## Getting things done

* Process management
    * Like Windows Task Manager, OSX Activity Monitor
    * `top`, `ps`, `jobs`
* Foreground and background
* Stay persistent with `screen`
* Need to go visual?
    * X11 forwarding, x2go, VNC

## Online resources

* http://www.ibm.com/developerworks/linux/library/l-lpic1-v3-103-1/
* http://linuxcommand.org/learning_the_shell.php
* http://www.tuxfiles.org/linuxhelp/cli.html
* http://www.linfo.org/command_line_lesson_1.html
* [Free book!](http://linuxcommand.org/tlcl.php)

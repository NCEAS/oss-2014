---
layout: lesson
root: ../..
title: Loops in Bash
author: "Matt Jones"
date: "July 22, 2014"
output: ioslides_presentation
---

## Loops tutorial objective

- Learn why its useful to use loops
- Practice basic loop syntax

## Why loops

- Automate repetitive tasks compared to the GUI
- Increase efficiency
- Fewer commands, less likelihood for errors

## A basic loop

```bash
$ for filen in paleo*
>    do echo $filen
> done
```

produces

```
paleo-mammals-v2.txt
paleo-mammals-v3.txt
paleo-mammals.txt
```

## Running multiple commands in a loop
```bash
$ for file in paleo-mammals-v?*
> do
>        echo $file
>        wc -l $file
>        diff -q paleo-mammals.txt $file
> done
```

produces

```
paleo-mammals-v2.txt
      23 paleo-mammals-v2.txt
Files paleo-mammals.txt and paleo-mammals-v2.txt differ
paleo-mammals-v3.txt
      23 paleo-mammals-v3.txt
Files paleo-mammals.txt and paleo-mammals-v3.txt differ
```

## Renaming files

- Imagine you have a lot of data files named similarly
- To rename all of them, try a loop like:

```bash
$ for filename in *.csv
> do
>    mv $filename orig-$filename
> done
```

## Bash scripts

- Series of commands can be saved in a file and run at any time
- Useful to write a program that automates a task
- Start with `#!` syntax to indicate which program should be used for the script
    - e.g., `#!/bin/bash` to use the bash shell

## A simple bash script

```bash
#!/bin/bash

# Example of a simple shell script
# Do not really use this for backup!
PREFIX="backup-"
FILES=$@
for file in $FILES
do
    cp $file $PREFIX$file
done
```

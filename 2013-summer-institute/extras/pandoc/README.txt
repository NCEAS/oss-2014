To convert Markdown -> S5 html slides, using customized css and NCEAS
logo:

1. Copy the s5 directory into .pandoc in your home directory, as in:
   ~/.pandoc/s5/default/

2. Incantation to create self-contained S5 html slides (ie., with
   embedded js, css, and images) :

  $ pandoc -i --self-contained -t s5 -s <file>.md -o <file>.html


# Don't read this till you try this yourself.

__code it yourself__  
![](https://dl.dropboxusercontent.com/u/2223411/gifs/talk_prep.gif)


Srsly
![](https://dl.dropboxusercontent.com/u/2223411/gifs/shocked.jpg)


ok here it is:


```r
chicks %>% select(-X) %>% gather(variable, measurement, -year, -nest.identity, -chick.identity) 
```
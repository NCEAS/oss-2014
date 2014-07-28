
# Don't read this till you try this yourself.


```r
chicks %>% select(-X) %>% gather(variable, measurement, -year, -nest.identity, -chick.identity) 
```
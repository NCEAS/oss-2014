
# Don't read this till you try this yourself.

__code it yourself__  
![](https://dl.dropboxusercontent.com/u/2223411/gifs/talk_prep.gif)


Srsly
![](https://dl.dropboxusercontent.com/u/2223411/gifs/shocked.jpg)


ok here it is:



```r
library(dplyr)
# I removed column X because it looked like they included a row number.
# Then I also specified the indicator variables by adding a - in front because the number of measured variables were too many and not in order. You may have a better solution here.
chicks %>% select(-X) %>% gather(variable, measurement, -year, -nest.identity, -chick.identity) 
```
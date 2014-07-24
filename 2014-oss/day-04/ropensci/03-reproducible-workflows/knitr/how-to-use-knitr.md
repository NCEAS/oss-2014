

# Reproducible documents using `knitr`

## Brief history of reproducible documents

The problem:

> Results from scientific research have to be reproducible to be trustwor- thy. We do not want a finding to be merely due to an isolated occur- rence, e.g. only one specific laboratorian can produce the results on one specific day, and nobody else can produce the same results under the same conditions.


## Advantages of using a reproducible workflow.

* Reduces errors
* If you make small changes (eg. change a few parameters and you'll have to remember to replace everything that might affect downstream). 
* Embed code within the document for easy review (fewer errors)
* Mostly importantly, it saves time.

## Markdown
Markdown is a really light weight markup that allows you to write documents (including reports, papers, scientific documents). 

A quick guide to syntax

```
# Top Heading
## Smaller heading
### More hash sings (until 6) creates nested headings
```

**How to embed R code**
<pre><code>
```{r}
# your R code
```
</code></pre>

**Add some options to your chunks**
<pre><code>
```{r chunk_name}
# your R code
```
</code></pre>

**You can also add more options to it.**
<pre><code>
```{r chunk_name, warning = FALSE, messages = FALSE}
# your R code
```
</code></pre>


**Even print nicely formatted tables**
<pre><code>
```{r, chunk_name}
library(pander)
# if this gives you an error install the package with
# install.packages("pander")
pandoc.table(mtcars[1:5, 1:3])
```
</code></pre>

**Also set options for figures**
<pre><code>
```{r chunk_name, fig.width = 6, fig.height = 4}
# your R code
```
</code></pre>


**How to embed figures**
<pre><code>
```{r}
library(ggplot2)
ggplot(data = iris, aes(Sepal.Length, Sepal.Width), color = Species) + 
geom_point(size = 3) + ggtitle("My first plot")
```
</code></pre>

**You can even include variables inline**
The mean sepal length across all species of irises is <pre><code>`r mean(iris$Sepal.Length)`</code></pre>. 


**And even equations**
<pre><code>
$Y = \beta_0 + \beta_1 x + \epsilon$
</pre></code>


---

## Exercise on `knitr`

* Create a document called `manuscript.md`
* Add three chunks
	* One to load, and print a part of the iris dataset.
	* Plot Sepal.Length against Sepal.Width
	* one more thing

If you've made it this far, then please place the green post it at the top of your computer.

* Convert this to a pdf

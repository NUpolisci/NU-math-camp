# Beyond Base R: Exploring the `tidyverse` {#ch8}

In this chapter: 

- Why `tidyverse`?

- The pipe `%>%` to chain functions and saving intermediate objects

- `join`, `filter`, `select`, and other modes of merging or subsetting data 

- Data manipulation, wrangling, and transformation 

- Conventions of tidyverse programming  

- An alternative to `tidyverse`: `data.table`

This chapter will largely rely on [Wickham and Grolemund's R for Data Science](https://r4ds.had.co.nz/transform.html) for its material. This is a great text that is great to revisit once you have mastered some of the basic concepts of programming in R. 


## What, why, how of `tidyverse`

Tidyverse is modern library of packages developed for modern data science. All of the accompanying packages and their underlying functions share similar design and grammar styles, meant for seamless interaction between functions among the library of packages. 

Packages in the core `tidyverse` within our scope: 

- `dplyr` is the modern toolkit for data manipulation. 

- `ggplot2` provides a framework and grammar for plotting data of different types and interacting with `dplyr` verbs to mutate data to make it more graph-able. 

- `tidyr` helps to consistently and tidily clean data. 

- `readr` a package for importing rectangular data of different file types. 

Other packages in the `tidyverse` you might encounter later: `forcats`, `stringr`, `tibble`, `purrr`, `lubridate`, `rvest`, `magrittr`. 

For more information on each of these and the greater power of the `tidyverse` check out the [webpage on these packages](https://www.tidyverse.org/packages/). 

So, why `tidyverse` over the tried and true base R? While base R is great for some things, it can also be really inefficient and difficult to combine different functions together in a meaningful workflow. The `tidyverse` package solves some of these inefficiencies given the relationships between packages in the library and the ways that `tidyverse` packages emphasize **piping**, or chaining together codes to form sophisticated chains of functions.  

Given that there is a similar language and interpretation across the `tidyverse` packages, it makes data analysis and data science a lot easier to manage, as opposed to having a multitude of different packages performing all these different steps in your code. However, the learning curve is high because there is a certain philosophy and grammar to the workflow. Navigating and employing this grammar is necessary to running `tidyverse` code that works. While this high learning curve can be confusing at times, you will thank yourself for putting the work at the front end of your programming journey because `tidyverse`'s efficiencies make up for it in the end. 

### Just one more thing! 
Before we move an inch further into this chapter, recall how to install and load packages from your R library as we went over in Chapter \@ref(ch6). If you did not install the `tidyverse` during those activities, do so now! The remainder of this chapter (and much of this text), will assume that you are working with `tidyverse` functions. After you make sure that you did install `tidyverse`, make sure that it is loaded via the `library()` function. 

Next, you will load the dataset `mtcars` that is already available in Base R. To do so merely run the function `data('mtcars')`. This is a play dataset with data from the 1974 *Motor Trend US* magazine that accounts for different specifications across 32 different cars. We realize this has nothing to do with politics or political science, **BUT** the dataset is really accessible, fairly small, and has data that span the various types we have already covered in previous chapters. There are also many examples out there using this dataset, so hopefully if you have any more questions you can find answers applied to the `mtcars` data, making it a bit more comfortable to follow along.

## The Pipe `%>%` 




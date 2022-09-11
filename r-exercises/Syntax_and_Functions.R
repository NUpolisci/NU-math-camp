# *****************************************************************
# OVERVIEW ####
# *****************************************************************
# Syntax_and_Functions.R
# Companion Code for Syntax and Functions R Session
# Math Camp 2022
# Data Source: ANES
# Author:
# Created On: 2022 09 12

# *****************************************************************
# CODE FROM CLASS ####
# *****************************************************************

# This section contains code from the R Syntax handout

## Vectors ####

# You can create vectors using c()
stats_programs <- c("Python", "R", "Stata", "SPSS", "SAS")

# And access them using their position, starting with 1
stats_programs[2]

# We can also do manipulations with vectors:
# Let's use the fibonacci sequence as an example:
fibonacci <- c(1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144)

# Suppose we only want the first 10 elements
fibonacci[1:10]

# Or if we just wanted 1, 3, and 10th element
fibonacci[c(1, 3, 10)]

# We can do math, too
# Let's start by adding 1 to each of the elements 
fibonacci + 1

# Or multiplying everything by 4
fibonacci * 4 

# Notice that nothing saves.

# To save, we need the assignment arrow <- 
# NEVER write over your original data
# Let's create a new vector and make it equal to 
#   the original
new_fibonacci <- fibonacci

# Let's make the second element 100
new_fibonacci[2] <- 100
new_fibonacci

## Data Frames ####

# Data frames are a collection of vectors
# Here are several vectors
state_abbv <- c("AL", "AK", "AZ", "AR", "CA")
state_fips <- c(1, 2, 4, 5, 6)
state_names <- c("Alabama", "Alaska", "Arizona", 
                 "Arkansas", "California")

# We can combine them using data.frame()
states <- data.frame(
  state_abbv,
  state_fips,
  state_names
)

## Working with Data ####

# Let's do some stuff with data from the ANES
# Make sure the ANES_2020 CSV is in the same folder as this
#   script and load it using read.csv()
ANES <- read.csv("ANES_2020.csv")

# We can access variables using the $ (at)
# And we can save them as a vector:
PARTY <- ANES$PARTY

# We can also do it this way:
PARTY <- ANES[, "PARTY"]

# Or, we can use names() to find the names of the data
#   frame and figure out which one is the PARTY variable
names(ANES)

# And access the party variable using its position:
# The first method uses matrix algebra logic: [row, cols]
#    To get the whole column, leave the rows blank and 
#    indicate the columns by position
PARTY <- ANES[, 2]

# Since a data frame is a collection of vectors, we can just
#    get the second vector as so:
PARTY <- ANES[2]

# We can get several columns using c()
DEMOGRAPHICS <- ANES[c(2:6)]

# And we can get several columns that follow a pattern
#   using the grepl() function
Parties <- ANES[c(grepl("Party", names(ANES)))]

# We can also access variables from a data frame using get()
get("gender", ANES)

### Data Dimensions ####

# We can see the number of rows and columns a data frame has
dim(ANES)

# We can also see the types of variables in the whole data frame
str(ANES)

# Or we can view the class of specific variables
class(ANES$PARTY)
class(ANES$FT_SCOTUS)

# We can conver variables to different classes
# Here is from character to factor
PARTY <- as.factor(ANES$PARTY)
class(PARTY)

# Here is from integer to numeric
SCOTUS <- as.numeric(ANES$FT_SCOTUS)
class(SCOTUS)

## Basic Data Wrangling ####

# I want an indicate variable for gender, where Female is 
#   TRUE and Male is FALSE
ANES$FEMALE[ANES$gender == "Female"] <- TRUE
ANES$FEMALE[ANES$gender != "Female"] <- FALSE

# I want to make the feeling thermometer variable for the
#   SCOTUS to be three categories:
ANES$SCOTUS_Cat[ANES$FT_SCOTUS >= 51] <- "Warm"
ANES$SCOTUS_Cat[ANES$FT_SCOTUS == 50] <- "Neutral"
ANES$SCOTUS_Cat[ANES$FT_SCOTUS <= 49] <- "Cold"

# We can view the distribution of a variable using table()
table(ANES$SCOTUS_Cat)

# or we can use prop.table() for proportions
prop.table(table(ANES$SCOTUS_Cat))

# This is the same as
tab <- table(ANES$SCOTUS_Cat)
prop.table(tab)

# We can also use sum
sum(ANES$SCOTUS_Cat == "Cold", na.rm = TRUE)

## Summary Statistics ####

# Let's calculate a mean of the FT_SCOTUS variable
mean(ANES$FT_SCOTUS)

# OOPS -- let's look at the documentation to see what 
#   went wrong
?mean()

# Oh....
mean(ANES$FT_SCOTUS, na.rm = TRUE)

# We can take these lessons and do other neat things
# Here is Median:
median(ANES$FT_SCOTUS, na.rm = TRUE)

# Here are quartiles
quantile(ANES$FT_SCOTUS, na.rm = TRUE)

# Here is a range
range(ANES$FT_SCOTUS, na.rm = TRUE)
# But we knew this already because that is how the survey
#   is designed!

# Here is variance
var(ANES$FT_SCOTUS, na.rm = TRUE)

# Here is teh Standard Deviation
sqrt(var(ANES$FT_SCOTUS, na.rm = TRUE))

# But why do that when you have
sd(ANES$FT_SCOTUS, na.rm = TRUE)

## For Loops ####

# Here is a loop
for (i in 1:10) {
  print(paste("This is Iteration", i))
}
# But this is not useful since we cannot use the results.

# Here is a blank vector to store things in
iterations <- c()
# And we can repeat the loop
for (i in 1:10) {
  iterations[i] <- paste("This is Iteration", i)
}
# And view the outcomes
iterations

## Custom Functions ####

# For this section, consider the following vector of 
#   dismal pay per hour of work
pay_per_hr <- c(8.5, 9, 8, 10, 9.5)

# We want to give everyone a 10% raise. We need a function
raise <- function(vec){
  # Empty vector to store results
  out <- c()
  # Iterate through the entire length of the vector because
  #   functions generally address one item only
  # length(vec) gives us the length of the vector
  for (i in 1:length(vec)) {
    # Find 10% of each element in vec
    inc <- 0.1*vec[i]
    # Add it to the original and add it to the output
    out[i] <- inc + vec[i]
  }
  # Return the output as a vector
  return(out)
}

# Let's use it
new_pay <- raise(pay_per_hr)
new_pay

# Functions take objects from the environment. If we want
#   to work with objects that are not environment, we 
#   need to do more work.

# Consider this data frame of pay (from before) and hours 
#   each person worked.
pay_df <- data.frame(
  hour_rate = new_pay,
  day_hours = c(10, 12, 9, 8, 10)
)

# I want to create a new variable that reduces the number of
#   hours by 2. This is to demonstrate how to work with colums 
#   of data frames. Because you can easily do this:
pay_df$day_hours - 2

# But life is not easy so we will do this
reduce_hour <- function(df, colname){
  # The df is a data frame in the environment and the
  #   colname is the name of a column as a character
  #   string
  # We can pull the column as we did earlier with the 
  #   PARTY variable
  temp = df[, colname]
  # Create a blank vector to store stuff
  new_hr = c()
  # Loop across the column and subtract 2 from each
  for (i in 1:length(temp)) {
    new_hr[i] = temp[i] - 2
  }
  # Bind the new vector to the original data frame
  df = cbind(df, new_hr)
  # Return the data frame
  return(df)
}

# What do we have?
pay_df2 <- reduce_hour(pay_df, "day_hours")
pay_df2

## If Else Statements


# Executes operations if conditions are met.

# hEre is our input to consider. Let's have an If Else
#   statement tell us if this is positive or negative
x = -5

# If x is positive, say so
if (x > 0) {
  print("Positive Number")
  # Otherwise, if x is negative, say that
} else if (x < 0) {
  print("Negative Number")
  # And then if both are not true, then say what x is
} else {
  print(paste("x is", x))
}

# Now let's complicate our lives some more and apply
#   this to the pay data frame. Suppose I want to see how
#   far people deviated from an 8 hour work day (absolute)
# Iterate through the pay data frame
for (i in 1:length(pay_df2$day_hours)) {
  # If the person works more than 8 hours
  if (pay_df2$day_hours[i] > 8) {
    # subtract 8 from hours
    pay_df2$desc_hr[i] = pay_df2$day_hours[i] - 8
    # If less than 8 hours
  } else if (pay_df2$day_hours[i] < 8) {
    # Subtract hours from 8
    pay_df2$desc_hr[i] = 8 - pay_df2$day_hours[i]
  } else {
    # Otherwise, put 0
    pay_df2$desc_hr[i] = 0
  }
}

# View the results
pay_df2

# *****************************************************************
# EXERCISE WORKSPACE ####
# *****************************************************************

# Both Exercises use the ANES data

## Exercise 1 ####

# For this exercise, you are going to write some code that will 
# allow you to loop through the ANES dataset and calculate the 
# mean for each of the feeling thermometer variables.
# Remember that all the feeling thermometer variables start 
# with `FT_`. Your solution should be a data frame with the 
# name of the variable on one column and the mean on a 
# second column.
# Hint: 4 major steps



## Exercise 2 ####

# Find out the number of people who feel warm, neutral or 
# cold to each of the feeling thermometers. The result 
# should be a data frame with the variable name as one 
# column, a column for number of cold, number of neutral, 
# and number of warm. 
# Hint: 5 major steps
# Warm is over 51, neutral is at 50 and cold is 49 or lower






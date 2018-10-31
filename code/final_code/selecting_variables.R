library(tidyverse)

###DATA WRANGLING-PART 1.----
###Selecting Columns: The Basics----

msleep %>%                                    #Take msleep dataset, and then...
  select(name, genus, sleep_total, awake) %>% #Select columns of interest...
  glimpse()                                   # Display results.

#Add a chunk of columns using start_col:end_col syntax.
msleep %>%                                          # Take msleep dataset, and the
  select (name:order, sleep_total:sleep_cycle) %>%  # Select range of columns
  glimpse()                                         # Display results

#Deselecting columns and chunk of columns using minus sign.
msleep %>%                                          # Take msleep datset, and then...
  select(-conservation, -(sleep_total:awake)) %>%   # Deselect columns of interest
  glimpse()                                         # Display results 

#Deselecting a whole chunk of columns and re-adding a column.
msleep %>%                                          # Take msleep dataset
  select(-(name:awake), conservation) %>%           # Deselect chunk of columns and re-add a column from deselected chunk
  glimpse()                                         # Display results

###Selecting Columns based of Partial Column Names----
#This can be done with partial matching by adding starts_with(),\
#end_with(), or contains(), in your select statement.

#using starts_with ().                    
msleep %>%                                # Take msleep dataset, and then
  select(name, starts_with("sleep")) %>%  # Select columns that matches pattern "sleep" exactly
  glimpse()                               # Display results

#using ends_with (), and contains().
msleep %>%                                      #Take msleep dataset, and then
  select(contains("eep"), ends_with("wt")) %>%  # Select columns that matches patterns
  glimpse()                                     # Display results

###Selecting Columns Based on Regex----
msleep %>%                     #Take msleep dataset, and then
  select(matches("o.+er")) %>% #select columns containing "o" and any other letters plus "er"
  glimpse()                    #Display results

###Selecting columns Based on Pre-identified Columns----
#set up columns upfront.
classification <- c("name", "genus", "vore", "order", "conservation") #Wrap columns of interest in an object

#select the columns that have been set up
msleep %>%                  #Take msleep dataset, and then...
  select(!!classification)  # Select all variables wrapped as classification

###Selecting Columns by their Data Type----
#Using select_if() to select numeric variables.

msleep %>%                  # Take msleep dataset, and then...
  select_if(is.numeric) %>% # Select numeric variable, and then...
  glimpse                   # Display results.

#Using select_if() to select factors.
msleep %>%                   # Take msleep dataset, and then...
  select_if(is.factor) %>%   # Select factor variables
  glimpse ()                 # Display results        

#Using select_if() to select character variables.
msleep %>%                      # Take msleep dataset, and then...
  select_if(is.character) %>%   # Select character variables in dataset
  glimpse()                     # Display results

#Selecting the negation of a statement using tilde.
msleep %>%                        # Take msleep dataset, and then...
  select_if(~!is.numeric(.)) %>%  # Select variables that are non-numeric 
  glimpse()                       # Display results

###Selecting Columns By Logical Expressions using select_if()----
#Select columns with a mean above 10
#Long version
msleep %>%                                 #Take msleep dataset, and then...
  select_if(is.numeric) %>%                # Select numeric variables
  select_if(~mean(., na.rm = TRUE)>10) %>% # Select numeric variables with mean above 10
  glimpse()                                # Display results

#Shorter version of the above code.
msleep %>% 
  select_if(~is.numeric(.) & mean(., na.rm = TRUE)>10) %>% 
  glimpse()

###Determining the amount of distinct values per column----
#Use the n_distinct().

msleep %>%                       # Take msleep dataset, and then...
  select_if(~n_distinct(.) < 10) # Select distinct columns, using ~to pass\
                                 # n_distinct() as a function to select_if(). 
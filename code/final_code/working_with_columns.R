#LOAD THE REQUIRED PACKAGE(S)----
library(tidyverse)

###Load the inbuilt Dataset from Package(s)----
#Reordering columns---- 
#1) Using select()

msleep %>%                                     #Take msleep dataset, and then...
  select(conservation, sleep_total, name) %>%  #Select variables of interest.
  glimpse()                                    # Display results.
                                               # Note that the order of selection determines\
                                               #final order

#2) Using everything()
#The function is very useful if your are just moving a few columns to the front\
#and then wish to add the remaining columns. It saves a lot of typing.

msleep %>%                                            #Take msleep dataset, and then...
  select(conservation, sleep_total, everything()) %>% # Move conservation and sleep total to the front, and add all the remaining columns.
  glimpse()                                           # Display results.

###Renaming Columns----
#1.) Using select().

msleep %>%                                                               #Take msleep dataset, and then...
  select(animal=name, sleep_total, extinction_threat = conservation) %>% # Rename name variable as animal, and conservation as extinction threat within select()
  glimpse                                                                # Display results

#2.) Using rename().
msleep %>%                                                #Take msleep dataset, and then...
  rename(animal=name, extinction_threat=conservation) %>% # Rename variables of interest
  glimpse()                                               # Display results.
                                                          # Note that the rename function retains all the columns in the results

###Reformatting all Column Names----
#To do this, you use the select_all() function. This function allows changes to all columns\
# and takes a function as an argument.
#1.) Change all Column nAmes to Upper Case.

msleep %>%                  #Take msleep dataset, and then...
  select_all(toupper) %>%   # Change all Variable names to uppercase.
  glimpse()                 # Display results

### Cleaning up white spaces in messy data----
# Let's make an unclean database with the inbuilt dataset.
msleep2 <- select(msleep, name, sleep_total, brainwt)
colnames(msleep2) <- c("name", "sleep total", "brain weight")
msleep2

# Note that the displayed dataset violates the rules of tidy data. It contains white spaces in variable names.
# Let's now clean up this messy dataset to conform to the rules of tidy data.

msleep2 %>%                            #Take msleep2 dataset, and then...
  select_all(~str_replace(., " ", "_")) # Replace white spaces with underscore using str_replace all()

###Cleaning up messy data that contains meta-data like question numbers----
#Let's make an unclean datatset with the inbuilt dataset

msleep2 <- select(msleep, name, sleep_total, brainwt)
colnames(msleep2) <- c("Q1 name", "Q2 sleep total", "Q3 brain weight")
msleep2[1:3,]

#Let's now clean up the messy dataset using select_all() in combination with str_replace().
msleep2 %>% 
  select_all(~str_replace(., "Q[0-9]+", "")) %>% 
  select_all(~str_replace(., " ", "_"))
                              
###Row names to columns----
# Note that you may sometimes encounter dataframes that have row names that are not actually columns\
# an example of such a dataframe is the mtcars dataset. 

mtcars %>%   #Take the mtcars dataset, and then...
  head()     # Display the first 6 rows
             # You will notice that the row have names but are not actually columns\
             # You can convert these row names to columns by using the rownames_to_column() function\
             # and specify a new column name as shown in the following code.

mtcars %>% 
  tibble::rownames_to_column("car_model") %>% 
  head()

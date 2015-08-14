#########################################################################################################
# Name             : Intro to Numpy Matrix Example
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################


# Manually create matrix
test = np.array([[1, 2,'A',23], [3, 4,'G',5], [5, 6,'A',8]])

# Dynamically create Matrix
        # col * row must equal what we have in our arrange function
test = np.arange(50).reshape((10,5))
print(test.shape)    

##
# Select all but last vector
test[:,:-1]

# Select all but last two vectors
test[:,:-2]

# Select only the last vector
test[:,[-1]]

# Select the first vector
test[:,[0]]

# Select the second vector
test[:,[1]]

# Select the third vector
test[:,[2]]

# Select the third and first vector
test[:,[0,2]]

##
# selecting via a list
li = [0,3,4]
test[:,li]


##
# Selecting the first row
test[0]

# Selecting the last row
test[-1]


##
# sum all values in the matrix
test.sum()

# sum all values in a vector
test[:,[0]].sum()

# sum the first row
test[0].sum()

# sum the last row
test[-1].sum()







#########################################################################################################
# Name             : Image Classification
# Date             : 06-10-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150610            initial
#########################################################################################################

# pip install PIL --allow-external PIL --allow-unverified PIL
# http://askubuntu.com/questions/427358/install-pillow-for-python-3
from sklearn import svm
import os
from PIL import Image

pip install Pillow

'Pillow' in sys.modules


## Functions from Yhat
STANDARD_SIZE = (200, 150)
def img_to_matrix(filename, verbose=False):
    """
    takes a filename and turns it into a numpy array of RGB pixels
    """
    img = Image.open(filename)
    if verbose==True:
        print("changing size from %s to %s" % (str(img.size), str(STANDARD_SIZE)))
    img = img.resize(STANDARD_SIZE)
    img = list(img.getdata())
    img = map(list, img)
    img = np.array(img)
    return(img)

def flatten_image(img):
    """
    takes in an (m, n) numpy array and flattens it 
    into an array of shape (1, m * n)
    """
    s = img.shape[0] * img.shape[1]
    img_wide = img.reshape(1, s)
    return(img_wide[0])


## Dogs vs Cats

## Motorcycles vs Bicyles

## Apples vs Oranges

img_dir = "F:\\Analytics_Process\\Python\\SampleData\\Images\\Fruit\\"
images = [img_dir+ f for f in os.listdir(img_dir)]
labels = ["Apples" if "Apples" in f.split('/')[-1] else "Orange" for f in images]

data = []
for image in images:
    img = img_to_matrix(image)
    img = flatten_image(img)
    data.append(img)

data = np.array(data)
data

## Micowaves vs Toasters

## Checks vs Licenese 

## Golf Course vs Park

## sidewalk vs walking path

clf = svm.SVC(gamma=0.001, C=100.)

clf.fit(digits.data[:-1], digits.target[:-1])  

clf.predict(digits.data[-1]) 
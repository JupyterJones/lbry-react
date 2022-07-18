<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../mystyle.css">
</head>

<body>
    <?php include '../menu.php'; ?>
    <?php include '../heading.php'; ?>

<h1>Numpy</h1>

<p>The NumPy library is the core library for scientific computing in Python. It provides a  high-performance multidimensional array object, and tools for working with these arrays. 
Use the following improt convention:</p><br /><br />  
Example:
<p>Using Numpy to blend two images.</p><br />
<pre>
You can use OpenCV function addWeighted like:

cv2.addWeighted(img1,0.5,img2,0.5,0)`
</pre>


<br />
<code>import numpy as np</code><br /><br />
<h2>Numpy Arrays</h2><br /> 
Creating Arrays<br /> 
<br />
a = np.array([1,2,3])
<br />
b = np.array([(1.5,2,3), (4,5,6)], dtype = float)
<br />
c = np.array([[(1.5,2,3), (4,5,6)],[(3,2,1), (4,5,6)]], dtype = float)
Initial Placeholders 
<br />
np.zeros((3,4)) #Create an array of zeros
<br />
np.ones((2,3,4),dtype=np.int16) #Create an array of ones
<br />
d = np.arange(10,25,5)#Create an array of evenly spaced values (step value)
<br />
np.linspace(0,2,9) #Create an array of evenlyspaced values (number of samples)
<br />
e = np.full((2,2),7)#Create a constant array
<br />
f = np.eye(2) #Create a 2X2 identity matrix
<br />
np.random.random((2,2)) #Create an array with random values
<br />
np.empty((3,2)) #Create an empty array
I/O 
Saving & Loading on Disk 
<br />
np.save('my_array' , a)
<br />
np.savez( 'array.npz', a, b)
<br />
np.load( 'my_array.npy')
Saving & Loading Text Files 
<br />
np.loadtxt("myfile.txt")
<br />
np.genfromtxt("my_file.csv", delimiter= ',')
<br />
np.savetxt( "myarray.txt", a, delimiter= " ")
Asking For Help 
<br />
np.info(np.ndarray.dtype)
Inspecting Your Array 
<br />
a.shape #Array dimensions
<br />
len(a)#Length of array
<br />
b.ndim #Number of array dimensions
<br />
e.size #Number of array elements
<br />
b.dtype  #Data type of array elements
<br />
b.dtype.name  #Name of data type
<br />
b.astype(int). #Convert an array to a different type
Data Types 
<br />
np.int64 #Signed 64-bit integer types
<br />
np.float32. #Standard double-precision floating point
<br />
np.complex. #Complex numbers represented by 128 floats
<br />
np.bool  #Boolean type storing TRUE and FALSE values
<br />
np.object #Python object type
<br />
np.string_ #Fixed-length string type
<br />
np.unicode_ #Fixed-length unicode type
Array Mathematics 
Arithmetic Operations 
<br />
g = a - b. #Subtraction
   array([[-0.5,0. ,0.], [-3. , -3. , -3. ]])
<br />
np.subtract(a,b) #Subtraction
<br />
b + a #Addition 
  array([[ 2.5, 4. , 6.],[5. ,7. ,9. ]])
<br />
np.add(b,a) #Addition 
<br />
a/b #Division 
 array([[0.66666667,1. ,1.],[0.25 ,0.4 ,0.5 ]])
<br />
np.divide(a,b) #Division 
<br />
a * b #Multiplication 
  array([[1.5, 4. ,9.],[ 4. , 10. , 18. ]])
<br />
np.multiply(a,b) #Multiplication 
<br />
np.exp(b) #Exponentiation
<br />
np.sqrt(b) #Square root
<br />
np.sin(a)  #Print sines of an array
<br />
np.cos(b) #Elementwise cosine
<br />
np.log(a)#Elementwise natural logarithm
<br />
e.dot(f) #Dot product 
 array([[7.,7.],[7.,7.]])
Comparison 
<br />
a == b #Elementwise comparison

 array([[False , True, True],
             [ False,False ,False ]], dtype=bool)
<br />
a< 2 #Elementwise comparison
   array([True, False, False], dtype=bool)
<br />
np.array_equal(a, b) #Arraywise comparison
Copying Arrays 
>>>h = a.view()#Create a view of the array with the same data
<br />
np.copy(a) #Create a copy of the array
>>>h = a.copy() #Create a deep copy of the array
Sorting Arrays 
<br />
a.sort() #Sort an array
<br />
c.sort(axis=0) #Sort the elements of an array's axis
Subsetting, Slicing, Indexing 
Subsetting

<br />
a[2] #Select the element at the 2nd index
  3
<br />
b[1,2] #Select the element at row 1 column 2(equivalent to b[1][2])
  6.0
Slicing

<br />
a[0:2]#Select items at index 0 and 1
 array([1, 2])
<br />
b[0:2,1] #Select items at rows 0 and 1 in column 1
  array([ 2.,5.])
<br />
b[:1] 
#Select all items at row0(equivalent to b[0:1, :])
  array([[1.5, 2., 3.]])
 <br />
c[1,...] #Same as[1,:,:]
 array([[[ 3., 2.,1.],[ 4.,5., 6.]]])
<br />
a[ : : -1] #Reversed array a array([3, 2, 1])
Boolean Indexing 

<br />
a[a<2] #Select elements from a less than 2
 array([1])
Fancy Indexing 

<br />
b[[1,0,1, 0],[0,1, 2, 0]] #Select elements(1,0),(0,1),(1,2) and(0,0)
  array([ 4. , 2. , 6. ,1.5])
<br />
b[[1,0,1, 0]][:,[0,1,2,0]] #Select a subset of the matrix’s rows and columns
 array([[ 4. ,5. , 6. , 4.],[1.5, 2. , 3. ,1.5],[ 4. ,5. , 6. , 4.],[1.5, 2. , 3. ,1.5]])

Array Manipulation 
Transposing Array 

<br />
i = np.transpose(b) #Permute array dimensions
<br />
i.T #Permute array dimensions
Changing Array Shape 

<br />
b.ravel() #Flatten the array
<br />
g.reshape(3, -2) #Reshape, but don’t change data
Adding/Removing Elements 

>>>h.resize((2,6)) #Return a new arraywith shape(2,6)
<br />
np.append(h,g) #Append items to an array
<br />
np.insert(a,1,5)  #Insert items in an array
<br />
np.delete(a,[1])  #Delete items from an array
Combining Arrays 

<br />
np.concatenate((a,d),axis=0) #Concatenate arrays
 array([1, 2, 3, 10, 15, 20])
<br />
np.vstack((a,b) #Stack arrays vertically(row wise)
 array([[1. , 2. , 3.],[1.5, 2. , 3.],[ 4. ,5. , 6. ]])
<br />
np.r_[e,f] #Stack arrays vertically(row wise)
<br />
np.hstack((e,f)) #Stack arrays horizontally(column wise)
 array([[7.,7.,1.,0.],[7.,7.,0.,1.]])
<br />
np.column_stack((a,d)) #Create stacked column wise arrays
 array([[1, 10],[ 2, 15],[ 3, 20]])
<br />
np.c_[a,d] #Create stacked column wise arrays
Splitting Arrays 

<br />
np.hsplit(a,3) #Split the array horizontally at the 3rd index
  [array([1]),array([2]),array([3])]
<br />
np.vsplit(c,2) #Split the array vertically at the 2nd index
  [array([[[ 1.5, 2. ,1.],[ 4. ,5. , 6. ]]]),
   array([[[ 3., 2., 3.],[ 4.,5., 6.]]])]

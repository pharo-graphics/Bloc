I represent an element transformation and support both 2D and 3D transformations.

For optimization purposes I use 2D matrix if 3D transformation was not requested. As soon as I'm transformed in 3D all further transformation will also happen with the help of 3D matrix.
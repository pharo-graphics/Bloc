I represent a matrix used for 3D affine transformations.
https://en.wikipedia.org/wiki/Transformation_matrix#Examples_in_3D_computer_graphics

My components are named according to mathematical convention:

 |  a11  a12  a13  a14  |                 |    sx     shy0  shz0   wx  |
 |  a21  a22  a23  a24  |       =>     |  shx0    sy     shz1   wy  |
 |  a31  a32  a33  a34  |                 |  shx1  shy1    sz      wz  |
 |  a41  a42  a43  a44  |                 |     x         y         z        w    |
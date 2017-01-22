transformations
translateX: aX Y: aY


" multiply receiver by translation matrix :

| sx   shx   x   |        | 1  0  px |             |	sx  shx  (sx*px + shx*py + x) |
| shy sy     y   |   *   | 0  1  py |   ===> | shy  sy  (shy*px + sy*py + y)  |
|  0     0     1   |       | 0  0   1  |             |  0     0    1  |

"
	x := aX "(sx*px) + (shx*py)" + x.
	y := aY "(shy*px) + (sy*py)" + y.

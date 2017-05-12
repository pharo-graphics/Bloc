accessing
length
	"Return euclidian norm (length) of this quaternion"
	<return: #Number>

	^ ((x * x) + (y * y) + (z * z) + (w * w)) sqrt
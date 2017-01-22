vector-transform
transformX: aX with: aY
	"Transform X coordinate taking Y coordinate into account.
	I am useful if you care about only one coordinate and don't
	want to waste object creation operation on unneeded Point"
	<return: #Number>

	^ (sx * aX) + (shx * aY) + x
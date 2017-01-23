vector-transform
transformY: aY with: aX
	"Transform Y coordinate taking X coordinate into account.
	I am useful if you care about only one coordinate and don't
	want to waste object creation operation on unneeded Point"
	<return: #Number>

	^ (shy * aX) + (sy * aY) + y
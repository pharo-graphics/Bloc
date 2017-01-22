accessing
expanded
	"Transform me so that origin and corner are rounded to integers.
	Rounding is done by upper value on origin and lower value on corner so that
	self is inside rounded rectangle."
	
	left := left floor.
	top := top floor.
	right := right ceiling.
	bottom := bottom ceiling
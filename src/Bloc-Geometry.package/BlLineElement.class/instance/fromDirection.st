anchor - geometry
fromDirection
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>
	
	^ (self fromPosition - self toPosition) asBlocVector
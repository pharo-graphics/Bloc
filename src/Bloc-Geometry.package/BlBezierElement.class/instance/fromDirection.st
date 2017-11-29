instance creation
fromDirection
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>
	| thePositions |	
	thePositions := self anchorPositions.

	^ (thePositions first - thePositions second) asBlocVector
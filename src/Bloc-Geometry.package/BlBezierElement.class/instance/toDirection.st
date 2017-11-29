instance creation
toDirection
	"Return a vector representing a direction in which the end of the curve is pointing"
	<return: #BlVector>
	| thePositions |	
	thePositions := self anchorPositions.

	^ (thePositions last - (thePositions at: thePositions size - 1)) asBlocVector
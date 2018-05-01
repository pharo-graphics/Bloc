api - vector functions
projection: aPoint
	"Return a projection of a given point on this ray"
	<return: #Point>
	| aNormalizedDirection |

	"
	P - point
	D - direction of line (unit length)
	A - point in line

	X - base of the perpendicular line

	    P
	   /|
	  / |
	 /  v
	A---X----->D

	(P-A).D == |X-A|

	X == A + ((P-A).D)D
	"
	
	self vector isZero
		ifTrue: [ ^ self point ].
	
	aNormalizedDirection := self vector normalized.
	
	^ self point + (((aPoint - self point) asBlocVector dotProduct: aNormalizedDirection) * aNormalizedDirection)
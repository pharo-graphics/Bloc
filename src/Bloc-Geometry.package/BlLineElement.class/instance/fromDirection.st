anchor - geometry
fromDirection
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>
	| aDirection |
	
	aDirection := (self fromPosition - self toPosition) asBlocVector.
	^ aDirection length isZero
		ifTrue: [ BlVector x: 1 y: 0 ]
		ifFalse: [ aDirection normalized ]
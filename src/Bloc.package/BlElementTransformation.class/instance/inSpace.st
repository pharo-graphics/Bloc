accessing
inSpace
	"Return a transformation that represents a convertion from space coordinates
	to the local coordinates of the owner element of this transformation"
	<return: #BlElementTransformation>
	| aMatrix |
	
	aMatrix := self matrix copy.
	aMatrix translateBy: self owner position.
	
	self owner parentsDo: [ :anElement |
		aMatrix multiplyBy: anElement transformation matrix.
		aMatrix translateBy: anElement position ].
	
	^ BlElementAbsoluteTransformation matrix: aMatrix
margin
cellSpacingOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading
	"Return cell spacing around aChildElement for the side defined by isHorizontal and isLeading.
	First of all I determine if cell is on the edge and use it as additional parameter to allow more precise
	computation.
	@see cellSpacingOf:isAtEdge:isHorizontal:isLeading: for more info."
	<return: #Number>

	| spec axis span isAtEdge |
	spec := isHorizontal
		ifTrue: [ aChildElement constraints horizontal spec ]
		ifFalse: [ aChildElement constraints vertical spec ].

	axis := self layout axis: isHorizontal.
	span := spec span.

	isAtEdge := isLeading
		ifTrue: [ span first = 1 ]
		ifFalse: [ span last = (axis count + 1) ].

	^ self layout cellSpacingOf: aChildElement isAtEdge: isAtEdge isHorizontal: isHorizontal isLeading: isLeading
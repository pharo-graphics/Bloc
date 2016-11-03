margin
cellSpacingOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading
	"Return cell spacing around aChildElement for the side defined by isHorizontal and isLeading.
	First of all I determine if cell is on the edge and use it as additional parameter to allow more precise
	computation.
	@see cellSpacingOf:isAtEdge:isHorizontal:isLeading: for more info."
	<return: #Number>

	| spec axis span isAtEdge |
	spec := isHorizontal
		ifTrue: [ aChildElement constraints grid horizontal spec ]
		ifFalse: [ aChildElement constraints grid vertical spec ].

	axis := self layout axis: isHorizontal.
	span := spec span.
	
	isAtEdge := isLeading
		ifTrue: [ span first = 1 ]
		ifFalse: [ span last = axis count ].

	^ self layout cellSpacingOf: aChildElement isAtEdge: isAtEdge isHorizontal: isHorizontal isLeading: isLeading
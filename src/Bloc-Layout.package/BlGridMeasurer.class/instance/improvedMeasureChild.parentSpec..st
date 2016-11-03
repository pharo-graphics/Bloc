measure
improvedMeasureChild: aChildElement parentSpec: anExtentSpec
	| horizontal spec span axis locations cellSize childSize|
	horizontal := self layout orientation isHorizontal.
	spec := horizontal
		ifTrue: [ aChildElement constraints grid horizontal spec ]
		ifFalse: [ aChildElement constraints grid vertical spec ].

	(spec absoluteAlignment: horizontal) isFill
		ifFalse: [ ^ self ].

	span := spec span.
	axis := self layout axis: horizontal.
	locations := axis locations.
	cellSize := (locations at: span last) - (locations at: span first).
	childSize := cellSize - (self totalMarginOf: aChildElement isHorizontal: horizontal).
	horizontal
		ifTrue: [ self
			measureChild: aChildElement
			parentSpec: anExtentSpec
			widthResizer:(BlLayoutResizer exact: childSize)
			heightResizer: aChildElement constraints vertical resizer ]
		ifFalse: [ self
			measureChild: aChildElement
			parentSpec: anExtentSpec
			widthResizer: aChildElement constraints horizontal resizer
			heightResizer: (BlLayoutResizer exact: childSize) ]
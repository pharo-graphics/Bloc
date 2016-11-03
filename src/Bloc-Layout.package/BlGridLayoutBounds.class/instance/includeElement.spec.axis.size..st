accessing
includeElement: anElement spec: aSpec axis: anAxis size: size
	|isHorizontal alignment newBefore|
	flexibility := flexibility and: aSpec flexibility.
	isHorizontal := anAxis horizontal.
	alignment := aSpec absoluteAlignment: isHorizontal.
	newBefore := alignment alignmentValue: anElement viewSize: size.
	self includeBefore: newBefore after: size - newBefore
accessing
includeElement: anElement spec: aSpec axis: anAxis size: size
	| alignment newBefore newAfter |
	flexibility := flexibility and: aSpec flexibility.
	alignment := aSpec absoluteAlignment: anAxis horizontal.
	newBefore := alignment alignmentValue: anElement viewSize: size.
	newAfter := size - newBefore.
	
	before < newBefore
		ifTrue: [	 before := newBefore ].
	after < newAfter
		ifTrue: [ after := newAfter ].
		
	self includeBefore: newBefore after: newAfter
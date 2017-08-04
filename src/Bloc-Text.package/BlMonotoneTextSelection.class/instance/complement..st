arithmetic
complement: aMonotoneTextSelection
	"Answer the complement of me and a given selection.
	Note: I return an empty selection if complement is empty and composite text selection
	if complement consists of two separate selections"
	<return: #BlTextSelection>
	
	(self overlaps: aMonotoneTextSelection)
		ifFalse: [ ^ self ].
		
	(aMonotoneTextSelection includes: self)
		ifTrue: [ ^ self class empty ].
	
	^ (aMonotoneTextSelection inside: self)
		"I am splitted in two selections"
		ifTrue: [
			BlCompositeTextSelection new
				select: self from to: aMonotoneTextSelection from;
				select: aMonotoneTextSelection to to: self to;
				yourself ]
		"result is one monotone selection"
		ifFalse: [ 			
			(self from < aMonotoneTextSelection from)
				ifTrue: [ self class from: self from to: (aMonotoneTextSelection from min: self to) ]
				ifFalse: [ self class from: (aMonotoneTextSelection to max: self from)  to: self to ]	]
rope - enumeration
from: aStart to: anEnd do: aBlock
	| leftSize isReversed |
	
	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.
	
	leftSize := left size.
	isReversed := anEnd < aStart.
	
	isReversed
		ifTrue: [
			aStart > leftSize
				ifTrue: [ right from: aStart - leftSize to: (anEnd max: leftSize + 1) - leftSize do: aBlock ].
			anEnd <= leftSize
				ifTrue: [ left from: (aStart min: leftSize) to: anEnd do: aBlock ] ]
		ifFalse: [ 
			aStart <= leftSize
				ifTrue: [ left from: aStart to: (anEnd min: leftSize) do: aBlock ].
			anEnd > leftSize
				ifTrue: [ right from: (aStart max: leftSize + 1) - leftSize to: anEnd - leftSize do: aBlock ] ]
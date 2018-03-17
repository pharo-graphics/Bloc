children - adding
addAll: aSequenceableCollection

	"if user passed array and our current array is empty, we could
	just replace it directly - no need to waste time making a copy of array"
	array := (array isEmpty and: [ aSequenceableCollection isArray ])
		ifTrue: [ aSequenceableCollection ]
		ifFalse: [ array, aSequenceableCollection ]
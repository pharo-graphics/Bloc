rope - accessing
insertItems: aCollection at: anIndex
	| afterInsertion |
	self assertIndexForInsert: anIndex.

	afterInsertion := self rope insertItems: aCollection at: anIndex + offset.
	^ afterInsertion from: offset + 1 to: offset + length + aCollection size
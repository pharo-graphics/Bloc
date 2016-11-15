children accessing
childAt: anIndex
	|offset|
	offset := self computeOffset: anIndex.
	^ controller childAt: offset
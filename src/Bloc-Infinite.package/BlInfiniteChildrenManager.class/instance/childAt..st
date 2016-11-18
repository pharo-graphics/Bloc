children accessing
childAt: anIndex
	"Returns the child at anIndex"
	<return: #BlElement>

	|offset|
	offset := self computeOffset: anIndex.
	^ controller childAt: offset
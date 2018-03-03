text - enumeration
iterator: aStartIndex to: anEndIndex
	"Return an iterator pointing to the character at anStartIndex and limited by anEndIndex"
	<return: #BrTextIterator>

	^ self subclassResponsibility
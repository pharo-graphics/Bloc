text - enumeration
iterator: anStartIndex to: anEndIndex
	"Return an iterator pointing to the first text item (character)"
	<return: #BrTextIterator>

	^ self subclassResponsibility
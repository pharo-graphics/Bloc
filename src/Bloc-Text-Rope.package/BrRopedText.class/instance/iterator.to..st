text - enumeration
iterator: anStartIndex to: anEndIndex
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BrTextIterator>

	^ BrRopedTextIterator text: self from: anStartIndex to: anEndIndex
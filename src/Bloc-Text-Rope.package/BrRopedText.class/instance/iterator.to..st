text - enumeration
iterator: aStartIndex to: anEndIndex
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BrTextIterator>

	^ BrRopedTextIterator text: self from: aStartIndex to: anEndIndex
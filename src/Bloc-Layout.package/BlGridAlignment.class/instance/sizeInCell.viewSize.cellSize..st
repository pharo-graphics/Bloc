alignment
sizeInCell: anElement viewSize: viewSize cellSize: cellSize
	"Returns the size of the view specified by this alignment.
	In the case of vertical alignments this method should return a height; for
	horizontal alignments this method should return the width.

	The default implementation returns viewSize.
		anElement - an element to which this alignment should be applied
		viewSize - the measured size of the element
		cellSize - the size of the cell into which this element will be placed"
	^ viewSize
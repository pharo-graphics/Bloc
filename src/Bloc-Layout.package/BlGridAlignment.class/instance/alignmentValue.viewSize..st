alignment
alignmentValue: anElement viewSize: viewSize
	"Returns an alignment value. In the case of vertical alignments the value
	returned should indicate the distance from the top of the view to the
	alignment location.
	
	For horizontal alignments measurement is made from the left edge of the component.

		view - the view to which this alignment should be applied
		viewSize - the measured size of the view"
	^ self subclassResponsibility
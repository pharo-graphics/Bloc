private
assignFromElementAndKeepVisibleFromEnd: anElement in: aLinearLayout
	| anOrientation aPreviousLayoutEnd aChildEnd aPreviousEndMargin |
	
	anOrientation := aLinearLayout orientation.

	aPreviousLayoutEnd := anOrientation endWithPadding - anOrientation totalSpaceChange.
	aChildEnd := anOrientation decoratedEnd: anElement.
	aPreviousEndMargin := aPreviousLayoutEnd - aChildEnd.
	
	coordinate := anOrientation endWithPadding - aPreviousEndMargin.
	
	"ensure we did not push child's top out of bounds because of this"
	aPreviousEndMargin > 0
		"we have room to shift bottom if necessary"
		ifTrue: [
			| aChildSize anEstimatedChildStart aLayoutStart aPreviousStartMargin aStartReference aStartMargin |
			aChildSize := anOrientation decoratedMeasurement: anElement.
			anEstimatedChildStart := coordinate - aChildSize.
			aLayoutStart := anOrientation startWithPadding.
			aPreviousStartMargin := (anOrientation decoratedStart: anElement) - aLayoutStart.
			aStartReference := aLayoutStart + (aPreviousStartMargin min: 0).
			aStartMargin := anEstimatedChildStart - aStartReference.
			aStartMargin < 0
				"offset to make top visible but not too much"
				ifTrue: [ coordinate := coordinate + (aPreviousEndMargin min: aStartMargin negated) ] ]
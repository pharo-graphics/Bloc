private
assignFromElementAndKeepVisibleFromStart: anElement in: aLinearLayout
	| anOrientation aChildStart aStartMargin |
	
	anOrientation := aLinearLayout orientation.
	aChildStart := anOrientation decoratedStart: anElement.
	aStartMargin := aChildStart - anOrientation startWithPadding.
	
	coordinate := aChildStart.

	aStartMargin > 0
		"we have room to fix end as well"
		ifTrue: [ 
			| anEstimatedEnd aPreviousLayoutEnd aPreviousEndMargin anEndReference anEndMargin |
			anEstimatedEnd := aChildStart + (anOrientation decoratedMeasurement: anElement).
			aPreviousLayoutEnd := anOrientation endWithPadding - anOrientation totalSpaceChange.
			aPreviousEndMargin := aPreviousLayoutEnd - (anOrientation decoratedEnd: anElement).
			anEndReference := anOrientation endWithPadding - (aPreviousEndMargin min: 0).
			anEndMargin := anEndReference - anEstimatedEnd.
			anEndMargin < 0
				ifTrue: [ coordinate := coordinate - (aStartMargin min: anEndMargin negated) ] ]
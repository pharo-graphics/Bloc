instance creation
direction: aPoint
	"Create a linear gradient in a given direction"
	<return: #BlLinearGradientPaint>
	| aDirection aStart anEnd aDelta |
	
	aDirection := aPoint asPoint.
	aDirection := aDirection isZero
		ifTrue: [ 1@0 ]
		ifFalse: [ aDirection normalized].

	aStart := 0 asPoint.
	anEnd := aStart + aDirection.	
	aDelta := aStart min: anEnd.

	^ self new
		start: aStart - aDelta;
		end: anEnd - aDelta;
		matchExtent: 1.0 asPoint
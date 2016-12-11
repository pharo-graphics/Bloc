layout
measure: anExtentMeasurementSpec
	"Measure my extent based on extent specifications represented by anExtentMeasurementSpec.
	Subclasses should not override me, instead override onMeasure:
	for concrete implementation.
	anExtentMeasurementSpec must not be nil"
	self assert: anExtentMeasurementSpec isNotNil.
	
	"Fast exit if I or any of my children did not request layout update
	and my previous measurement specification equals to new one"
	(self isLayoutRequested not
		and: [ self layout previousMeasurementSpec = anExtentMeasurementSpec ])
		ifTrue: [ ^ self ].
		
	
	"Perform measuring algorithm"
	self onMeasure: anExtentMeasurementSpec.
	"Store extent specification to be used for checking next time measure: is sent"
	self layout previousMeasurementSpec: anExtentMeasurementSpec
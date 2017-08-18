layout
measure: anExtentMeasurementSpec
	"Measure my extent based on extent specifications represented by anExtentMeasurementSpec.
	Subclasses should not override me, instead override onMeasure:
	for concrete implementation.
	anExtentMeasurementSpec must not be nil"
	self
		assert: [ anExtentMeasurementSpec isNotNil ]
		description: [ 'Extent spec must not be nil' ].
	
	"Fast exit if I or any of my children did not request layout update
	and my previous measurement specification equals to new one"
	(self isLayoutRequested not
		and: [ self layout previousMeasurementSpec = anExtentMeasurementSpec ])
		ifTrue: [ ^ self ].

	"we have to eat layout request first marking it as false in order
	to do a second or third layout pass if needed.
	It works as follows: if during measurement or layout an element
	requests a layout (because of event for example) #waitingLayout
	is put back to true and we will do another layout pass as result"
	self layout waitingLayout: false.

	"Store extent specification to be used for checking next time measure: is sent"
	self layout previousMeasurementSpec: anExtentMeasurementSpec.

	"Perform measuring algorithm"
	self onMeasure: anExtentMeasurementSpec.
	
testing
hasSkippedNaiveMeasurements: anElement
	"Return true if any of anElement's children was skipped
	during naive measurement pass, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ anElement children accountedByLayout anySatisfy: [ :child | self shouldSkipNaiveMeasure: child ]
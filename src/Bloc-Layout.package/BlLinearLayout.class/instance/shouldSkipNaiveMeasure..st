testing
shouldSkipNaiveMeasure: anElement
	"Return true if anElement should not be measured during first
	naive pass, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ self orientation lengthMode isExact
		and: [ (self orientation lengthProperties: anElement) resizer isMatchParent ]
computing
count: aNumber
	self assert: aNumber isNotNil.
	"self
		assert: (aNumber ~= UNDEFINED and: [ aNumber < self maxIndex ])
		descriptionBlock: [ 'aNumber must be greater or equal to maxIndex (', self maxIndex asString, ') but is ', aNumber asString ]."

	definedCount := aNumber
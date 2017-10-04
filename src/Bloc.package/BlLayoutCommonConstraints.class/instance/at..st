accessing
at: aLayoutClass
	| aConstraints |
	
	"In most casese there is only one layout-specific constraint that is accessed extremely often.
	We can optimize lookup for this particular case by storing a type of previosly accessed constraint"
	previouslyAccessedConstraintsType == aLayoutClass
		ifTrue: [ ^ previouslyAccessedConstraints ].
	
	constraints
		ifNil: [ constraints := Dictionary new ].
	
	aConstraints := constraints
		at: aLayoutClass
		ifAbsentPut: [ aLayoutClass constraints ].
	
	previouslyAccessedConstraints := aConstraints.
	previouslyAccessedConstraintsType := aLayoutClass.
	
	^ aConstraints
	
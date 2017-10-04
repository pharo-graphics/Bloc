accessing
at: aLayoutClass
	"Return a layout constrait object specific for a given layout defined by its class.
	Returned constraint can not be nil"
	<return: #BlLayoutConstraints>
	| aConstraints |
	
	"In most cases there is only one layout-specific constraint that is accessed extremely often.
	We can optimize lookup for this particular case by storing a type of previously accessed constraint"
	previouslyAccessedConstraintsType == aLayoutClass
		ifTrue: [ ^ previouslyAccessedConstraints ].
	
	constraints
		ifNil: [ constraints := Dictionary new ].

	aConstraints := constraints
		at: aLayoutClass
		ifAbsentPut: [ aLayoutClass constraints ].

	"Store the reference to the constraints and its type for optimization purpose described above"
	previouslyAccessedConstraints := aConstraints.
	previouslyAccessedConstraintsType := aLayoutClass.
	
	^ aConstraints
	
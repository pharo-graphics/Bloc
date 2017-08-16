paragraph - measuring
measureOn: aCanvas
	"Measure myself with a given canvas as a backend-specific context.
	Note: I double dispatch through aCanvas to support multiple completely different canvasses"

	self text lockDuring: [ aCanvas measureTextParagraph: self ].
	
	"we should store a session of the last successfull measurement"
	session := Smalltalk session.

	self
		assert: [ self isNotEmpty ]
		description: [ 'I must not be empty after measurement!' ]
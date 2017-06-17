accessing
bottomLeft: aNumber
	"Initialize bottom left corner radius with a given number.
	It can be done only once"
	
	self
		assert: [ bottomLeft isNil ]
		description: [ 'Can not change bottom left radius, I am immutable!' ].

	bottomLeft := aNumber
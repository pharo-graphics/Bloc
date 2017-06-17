accessing
bottomRight: aNumber
	"Initialize bottom right corner radius with a given number.
	It can be done only once"

	self
		assert: [ bottomRight isNil ]
		description: [ 'Can not change bottom right radius, I am immutable!' ].

	bottomRight := aNumber
accessing
topRight: aNumber
	"Initialize top right corner radius with a given number.
	It can be done only once"

	self
		assert: [ topRight isNil ]
		description: [ 'Can not change top right radius, I am immutable!' ].

	topRight := aNumber
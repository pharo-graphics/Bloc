accessing
topLeft: aNumber
	"Initialize top left corner radius with a given number.
	It can be done only once"

	self
		assert: [ topLeft isNil ]
		description: [ 'Can not change top left radius, I am immutable!' ].

	topLeft := aNumber
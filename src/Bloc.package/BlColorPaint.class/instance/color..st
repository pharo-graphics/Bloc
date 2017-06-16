accessing
color: aColor
	"Initialize me with a given Color"
	self
		assert: [ color isNil ]
		description: [ 'Color paint is immutable!' ].

	color := aColor
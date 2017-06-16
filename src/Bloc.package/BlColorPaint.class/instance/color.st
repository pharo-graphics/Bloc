accessing
color
	"Return paint's underlying color.
	color can not be nil"
	<return: #Color>
	
	self
		assert: [ color isNotNil ]
		description: [ 'Color can not be nil' ].
	
	^ color
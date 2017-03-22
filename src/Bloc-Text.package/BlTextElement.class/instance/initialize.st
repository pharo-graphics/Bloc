initialization
initialize
	super initialize.
	
	text := self defaultText.
	"Text layout is created during measurement in onMeasure:"
	paragraph := nil.
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ]
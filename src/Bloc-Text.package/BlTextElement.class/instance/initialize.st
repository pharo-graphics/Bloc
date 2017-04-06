initialization
initialize
	super initialize.
	
	text := self defaultText.
	"Text layout is created during measurement in onMeasure:"
	paragraph := nil.
	
	"self border: (BlBorder paint: Color random width: 1) .
	self background: Color yellow muchLighter muchLighter."
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ]
initialization
initialize
	super initialize.
	
	text := self defaultText.
	"Text layout is created during measurement in onMeasure:"
	textLayout := nil
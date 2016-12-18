unique instance
default
	"I return a unique instance of an interpolator with default configuration"
	^ default ifNil: [ default := self new ]
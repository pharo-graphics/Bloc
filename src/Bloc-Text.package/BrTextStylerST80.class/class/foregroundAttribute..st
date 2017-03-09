attributes
foregroundAttribute: aPaint
	"Create and return a text foreground attribute for a given paint.
	aPaint can be a color, gradient or any other object that represents a paint
	and is polymorphic with a canvas-specific paint or that knows how to convert
	itself to an actual paint using double dispatch (e.g. asSpartaPaintOn:)"
	<return: #BrTextForegroundAttribute>

	^ BrTextForegroundAttribute paint: aPaint
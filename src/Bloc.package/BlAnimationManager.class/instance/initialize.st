initialization
initialize
	super initialize.
	
	"Animations collection must be immutable array to support
	robust removing of animations while running animations"
	animations := Array new
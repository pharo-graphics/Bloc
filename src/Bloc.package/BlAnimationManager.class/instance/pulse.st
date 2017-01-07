animate
pulse
	| theAnimations |
	
	"We store reference to animations Array because it is possible
	that a random animation is removed while enumerating a collection"
	theAnimations := animations.
	theAnimations do: [ :anAnimation | anAnimation pulse ]
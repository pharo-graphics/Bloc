private - testing
shouldBeKeptAsChild
	"Return true if we have animations referring to this element holder or not.
	This is inverted, a bit more domain specific version of isRecyclable"
	<return: #Boolean>

	^ 	self flags hasNotRecyclable
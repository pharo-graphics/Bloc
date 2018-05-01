pulse
initStart
	super initStart.

	currentIndex := 0.
	self animations do: [ :anAnimation |	anAnimation reset ]
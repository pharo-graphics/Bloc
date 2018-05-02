api - scrolling
flingBy: aVelocityPoint
	"Positive velocity means that the finger/cursor is moving down the screen, which means we want to scroll towards the top.
	Initial velocity is given in points/second"

	self beSettling.

	lastFlingX := self scrollable scrollPosition x.
	lastFlingY := self scrollable scrollPosition y.
	scroller
		fling: self scrollable scrollPosition
		velocity: aVelocityPoint
		min: self scrollable scrollMinimum
		max: self scrollable scrollMaximum
		overshot: self scrollable scrollOvershot.

	self postOnAnimation
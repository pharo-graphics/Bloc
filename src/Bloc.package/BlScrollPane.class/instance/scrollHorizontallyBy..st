api - scrolling
scrollHorizontallyBy: aNumber
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	| aContent |
	
	aContent := self children first.
	aContent relocate: aContent measuredBounds position + (aNumber @ 0).

	^ aNumber
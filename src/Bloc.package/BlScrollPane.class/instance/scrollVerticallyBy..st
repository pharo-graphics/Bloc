api - scrolling
scrollVerticallyBy: aNumber
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>
	| aContent |
	
	aContent := self children first.
	aContent relocate: aContent measuredBounds position + (0 @ aNumber).
	scrollPosition := scrollPosition + (0 @ aNumber).

	^ aNumber
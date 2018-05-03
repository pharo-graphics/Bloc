api - scrolling
scrollVerticallyBy: aNumber
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>
	| aContent |
	
	aContent := self children first.
	scrollPosition := scrollPosition + (0 @ aNumber).
	aContent relocate: scrollPosition.

	^ aNumber
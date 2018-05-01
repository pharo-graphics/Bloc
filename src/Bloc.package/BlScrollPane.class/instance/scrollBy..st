scrolling
scrollBy: aPoint
	"Instant scroll by the given amount of pixels along either axis"
	| aContent dX dY |
	
	aContent := self children first.
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := aContent position x + dX.
			aMinPosition := (self width - aContent width) min: 0.
			aMaxPosition := 0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dX := aNewClampedPosition - aContent position x ]
		ifFalse: [ dX := 0 ].
	
	self canScrollVertically
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := aContent position y + dY.
			aMinPosition := (self height - aContent height) min: 0.
			aMaxPosition := 0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dY := aNewClampedPosition - aContent position y ]
		ifFalse: [ dY := 0 ].
	
	dX isZero
		ifFalse: [self scrollHorizontallyBy: dX  ].

	dY isZero
		ifFalse: [ self scrollVerticallyBy: dY ]
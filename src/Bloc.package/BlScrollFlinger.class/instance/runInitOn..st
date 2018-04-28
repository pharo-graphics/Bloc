private
runInitOn: anOverScroller
	<return: #BlScrollFlingerState>
	| aState |

	aState := self createState.
	aState
		x: anOverScroller currentX;
		y: anOverScroller currentY;
		dX: aState x - lastFlingX;
		dY: aState y - lastFlingY;
		hResult: 0;
		vResult: 0;
		overscrollX: 0;
		overscrollY: 0.
	
	lastFlingX := aState x.
	lastFlingY := aState y.
	
	^ aState
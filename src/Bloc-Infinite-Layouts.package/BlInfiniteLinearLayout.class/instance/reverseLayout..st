accessing
reverseLayout: aBoolean
	"Used to reverse item traversal and layout order.
	This behaves similar to the layout change for RTL elements. When set to true, first item is
	laid out at the end of the UI, second item is laid out before it etc"

	self assertNotInLayoutOrScroll.
	
	reverseLayout = aBoolean
		ifTrue: [ ^ self ].
		
	reverseLayout := aBoolean.
	self requestLayout
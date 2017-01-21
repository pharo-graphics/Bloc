scrolling
scrollVerticallyBy: aNumber
	"@see BlInfiniteLayout>>#scrollVerticallyBy:"
	<return: #Number>
	
	self orientation isHorizontal
		ifTrue: [ ^ 0 ].

	^ self scrollBy: aNumber
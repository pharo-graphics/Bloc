scrolling
scrollHorizontallyBy: aNumber
	"@see BlInfiniteLayout>>#scrollHorizontallyBy:"
	<return: #Number>
	
	self orientation isVertical
		ifTrue: [ ^ 0 ].
		
	^ self scrollBy: aNumber
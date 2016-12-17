scrolling
scrollToPosition: aPosition
	"Convenience method to scroll to a certain datasource position.
	InfiniteElement does not implement scrolling logic, rather forwards the call to
   InfiniteElement>>#scrollToPosition:"

	layoutFrozen
		ifTrue: [ ^ self ].
		
	self stopScroll.
	self layout scrollToPosition: aPosition.
	self awakenScrollBars
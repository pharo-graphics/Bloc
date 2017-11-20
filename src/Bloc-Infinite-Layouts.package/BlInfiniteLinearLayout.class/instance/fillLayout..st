layout
fillLayout: shouldStopOnFocusable
	<return: #Number>
	| aStart aRemainingSpace aBreak |
	
	aStart := layoutState availableSpace.
	"We can only recycle if scrolling offset is set"
	layoutState hasScrollingOffset
		ifTrue: [
			layoutState availableSpace < 0
				ifTrue: [ layoutState scrollingOffset: layoutState scrollingOffset + layoutState availableSpace ]. 
			self recycleChildren ].
	
	aRemainingSpace := layoutState availableSpace + layoutState extraSpace.
	aBreak := false.
	[ aBreak not and: [
		(layoutState isInfinite or: [ aRemainingSpace > 0 ]) and: [
			layoutState hasMoreItems: self state ] ] ]
		whileTrue: [ 
			| aResult |
			aResult := self layoutChunk.
			aResult finished
				ifTrue: [ aBreak := true ]
				ifFalse: [ 
					aRemainingSpace := aRemainingSpace + (self fillLayoutChunkResult: aResult).
					"Break if we found focusable element and if we should stop on it"
					aBreak := shouldStopOnFocusable and: [ aResult focusable ] ] ].
	
	"Make sure that class invariant is fulfilled"
	self validateChildrenOrder.
	
	^ aStart - layoutState availableSpace
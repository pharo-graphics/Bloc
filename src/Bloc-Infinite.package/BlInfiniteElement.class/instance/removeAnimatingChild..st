children - add/remove
removeAnimatingChild: anElement
	"Removes an element from the animatingElements list.
	Return true if an animating element is removed, false otherwise"
	<return: #Boolean>
	| isRemoved |
	
	self eatRequestLayout.
	isRemoved := childrenManager removeChildIfHidden: anElement.
	isRemoved
		ifTrue: [ 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			recycler unscrapHolder: anElementHolder.
			recycler recycleElementHolder: anElementHolder ].
	
	"only clear request eaten flag if we removed the element"
	self resumeRequestLayout: isRemoved not.
	^ isRemoved
scrolling
scrollBy: aNumber
	<return: #Number>
	| aLayoutDirection anAbsoluteDelta aConsumedSpace aScrolledDistance |

	(self hasChildren not or: [ aNumber isZero ])
		ifTrue: [ ^ 0 ].

	layoutState allowRecycling: true.
	aLayoutDirection := aNumber > 0
		ifTrue: [ BlInfiniteLinearLayoutDirection end ]
		ifFalse: [ BlInfiniteLinearLayoutDirection start ].
	anAbsoluteDelta := aNumber abs.

	self
		updateLayoutState: aLayoutDirection
		requiredSpace: anAbsoluteDelta
		canUseExistingSpace: true.
	
	aConsumedSpace := layoutState scrollingOffset + (self fillLayout: false).
	aConsumedSpace < 0
		"Don't have any more elements to scroll"
		ifTrue: [ ^ 0 ].

	aScrolledDistance := anAbsoluteDelta > aConsumedSpace
		ifTrue: [ aLayoutDirection multiplier * aConsumedSpace ]
		ifFalse: [ aNumber ].
		
	self orientation moveChildrenBy: aScrolledDistance negated.
	layoutState lastScrolledDelta: aScrolledDistance.

	^ aScrolledDistance
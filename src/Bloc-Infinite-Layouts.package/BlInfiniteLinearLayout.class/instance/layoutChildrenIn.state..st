layout
layoutChildrenIn: aBlInfiniteRecycler state: aBlInfiniteState
	"layout algorithm:
  			1) by checking children and other variables, find an anchor coordinate and an anchor item position.
			2) fill towards start, stacking from bottom
			3) fill towards end, stacking from top
			4) scroll to fulfill requirements like stack from bottom.
				create layout state"
	| anExtraSpace anOffsetSpace |
	
	(self hasPendingScrollPosition
		and: [ aBlInfiniteState itemCount isZero ])
			ifTrue: [ ^ self removeAndRecycleAllChildrenIn: aBlInfiniteRecycler ].

	layoutState allowRecycling: false.
	"resolve layout direction"
	self resolveShouldLayoutReverse.
	
	"prepare and update anchor"
	self prepareAnchorInfo: anchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState.
	
	"Initialize anchor and compute position + coordinate"
	anExtraSpace := self computeExtraLayoutSpace.
	
	self detachAndScrapAttachedChildren.
	layoutState isInfinite: self resolveIsInfinite.
	layoutState isPreLayout: self state isPreLayout.

	anOffsetSpace := self layoutChildrenFill: anExtraSpace.
	anOffsetSpace := self layoutChildrenFixGaps: anOffsetSpace.
	self layoutChildrenForPredictiveAnimations: anOffsetSpace.
	
	self state isPreLayout
		ifTrue: [ anchorInfo reset ]
		ifFalse: [ self orientation layoutCompleted ].
		
	lastStackFromEnd := stackFromEnd.
	self validateChildrenOrder
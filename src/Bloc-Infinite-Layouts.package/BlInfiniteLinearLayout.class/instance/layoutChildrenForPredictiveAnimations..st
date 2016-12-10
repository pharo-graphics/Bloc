layout
layoutChildrenForPredictiveAnimations: anOffsetSpace
	| aStartOffset anEndOffset aScrapExtraStart aScrapExtraEnd aFirstChildPosition |
	
	"If there are scrap children that we did not layout, we need to find where they did go
	and layout them accordingly so that animations can work as expected.
	This case may happen if new elements are added or an existing element expands and pushes
	another element out of bounds."

	(self state willRunPredictiveAnimations and: [
		self hasChildren and: [ 
			self state isPreLayout not and: [ 
				self supportsPredictiveItemAnimations ] ] ])
		ifFalse: [ ^ self ].

	"to make the logic simpler, we calculate the size of children and use fill."
	aStartOffset := anOffsetSpace x.
	anEndOffset := anOffsetSpace y.
	aScrapExtraStart := aScrapExtraEnd := 0.
	aFirstChildPosition := self childPositionOf: (self childAt: 1).
	self recycler attachedScrap
		select: [ :anElementHolder | anElementHolder isRemoved not ]
		thenDo: [ :anElementHolder |
			| aPosition aLayoutDirection |
			aPosition := anElementHolder layoutPosition.
			aLayoutDirection := (aPosition < aFirstChildPosition) ~= shouldReverseLayout
				ifTrue: [ BlInfiniteLinearLayoutDirection start ]
				ifFalse: [ BlInfiniteLinearLayoutDirection end ].
			aLayoutDirection isStart
				ifTrue: [ aScrapExtraStart := aScrapExtraStart + (self orientation decoratedMeasurement: anElementHolder itemElement) ]
				ifFalse: [ aScrapExtraEnd := aScrapExtraEnd + (self orientation decoratedMeasurement: anElementHolder itemElement) ] ].
	
	layoutState scrapList: self recycler attachedScrap.
	
	aScrapExtraStart > 0
		ifTrue: [ 
			| anAnchorElement |
			anAnchorElement := self childClosestToStart.
			self updateLayoutStateToFillStart: (self childPositionOf: anAnchorElement) offset: aStartOffset.
			layoutState extraSpace: aScrapExtraStart.
			layoutState availableSpace: 0.
			layoutState assignPositionFromScrapList.
			self fillLayout: false ].
	
	aScrapExtraEnd > 0
		ifTrue: [ 
			| anAnchorElement |
			anAnchorElement := self childClosestToEnd.
			self updateLayoutStateToFillEnd: (self childPositionOf: anAnchorElement) offset: anEndOffset.
			layoutState extraSpace: aScrapExtraEnd.
			layoutState availableSpace: 0.
			layoutState assignPositionFromScrapList.
			self fillLayout: false ].

	layoutState clearScrapList
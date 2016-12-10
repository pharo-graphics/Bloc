layout
layoutChildrenAnchor
	"I am a first step in layout algorithm; by checking children and other variables,
	I find an anchor coordinate and an anchor item position"
	<return: #Point>
	| anExtraSpace anExtraForStart anExtraForEnd aStartOffset anEndOffset aFirstLayoutItemDirection |

	(anchorInfo isValid not
		or: [ self hasPendingScrollPosition ])
			ifTrue: [ 
				anchorInfo reset.
				anchorInfo layoutFromEnd: shouldReverseLayout ~= stackFromEnd.
				"calculate anchor position and coordinate"
				self updateAnchorInfo: anchorInfo.
				anchorInfo isValid: true	].
	
	"Linear layout may decide to layout items for 'extra' pixels to account for scrolling target,
	caching or predictive animations."
	anExtraSpace := self computeExtraLayoutSpace.
	anExtraForStart := anExtraForEnd := 0.
	
	" If the previous scroll delta was less than zero, the extra space should be laid out
		at the start. Otherwise, it should be at the end"
	
	layoutState lastScrolledDelta >= 0
		ifTrue: [
			anExtraForStart := 0.
			anExtraForEnd := anExtraSpace ]
		ifFalse: [
			anExtraForStart := anExtraSpace.
			anExtraForEnd := 0 ].
		
	anExtraForStart := anExtraForStart + self orientation startWithPadding.
	anExtraForEnd := anExtraForEnd + self orientation endWithPadding.
	
	(self state isPreLayout and: [
		self hasPendingScrollPosition and: [
			self hasPendingScrollPositionOffset ] ])
		ifTrue: [ 
			"if the child is visible and we are going to move it around, we should layout
			extra items in the opposite direction to make sure new items animate nicely
			instead of just fading in"
			(self childAtPosition: pendingScrollPosition) ifNotNil: [ :anElement |
				| aCurrentOffset anUpcomingOffset |
				aCurrentOffset := 0.
				anUpcomingOffset := 0.
				
				shouldReverseLayout
					ifTrue: [ 
						aCurrentOffset := self orientation endWithPadding - (self orientation decoratedEnd: anElement).
						anUpcomingOffset := aCurrentOffset - pendingScrollPositionOffset ]
					ifFalse: [ 
						aCurrentOffset := (self orientation decoratedStart: anElement) - self orientation startWithPadding.
						anUpcomingOffset := pendingScrollPositionOffset - aCurrentOffset ].
					
					anUpcomingOffset > 0
						ifTrue: [ anExtraForStart := anExtraForStart + anUpcomingOffset ]
						ifFalse: [ anExtraForEnd := anExtraForEnd - anUpcomingOffset ] ] ].
	
	aStartOffset := 0.
	anEndOffset := 0.
	aFirstLayoutItemDirection := (anchorInfo layoutFromEnd
		ifTrue: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection head ] ]
		ifFalse: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ] ]).
	
	self onAnchorReady: anchorInfo firstLayoutItemDirection: aFirstLayoutItemDirection.
	
	^ anExtraForStart @ anExtraForEnd
layout
computeExtraLayoutSpace
	"I am a first step in layout algorithm; by checking children and other variables,
	I find an anchor coordinate and an anchor item position"
	<return: #Point>
	| anExtraSpace anExtraForStart anExtraForEnd |
	
	"Linear layout may decide to layout items for 'extra' pixels to account for scrolling target,
	caching or predictive animations."
	anExtraSpace := self extraLayoutSpace.
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
	anExtraForEnd := anExtraForEnd + self orientation paddingEnd.
	
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
	
	^ anExtraForStart @ anExtraForEnd
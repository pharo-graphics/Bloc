private - scrolling
scrollByInternal: aDeltaPoint from: anEventPoint
	<return: #Boolean>
	| unconsumedX unconsumedY consumedX consumedY |

	unconsumedX := unconsumedY := consumedX := consumedY := 0.
	
	self consumePendingDataSourceCommands.
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	aDeltaPoint x isZero
		ifFalse: [ 
			consumedX := self layout scrollHorizontallyBy: aDeltaPoint x.
			unconsumedX := aDeltaPoint x - consumedX ].
	aDeltaPoint y isZero
		ifFalse: [ 
			consumedY := self layout scrollVerticallyBy: aDeltaPoint y.
			unconsumedY := aDeltaPoint y - consumedY ].
	
	self repositionShadowingElements.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	
	self hasItemDecorations
		ifTrue: [ self invalidate ].
	
	self overScrollMode ~= BlOverScrollMode never
		ifTrue: [ 
			anEventPoint ifNotNil: [ 
				self pullGlows: anEventPoint overscroll: unconsumedX @ unconsumedY ].
			self considerReleasingGlowsOnScroll: aDeltaPoint ].
	
	(consumedX isZero and: [ consumedY isZero ])
		ifFalse: [ self dispatchOnScrolled: consumedX @ consumedY ].
		
	self awakenScrollBars
		ifFalse: [ self invalidate ].
	
	^ consumedX isZero not or: [ consumedY isZero not ]
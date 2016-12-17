running
runFinalizeOn: anOverScroller with: aState
	| fullyConsumedHorizontal fullyConsumedVertical fullyConsumedAny |
	
	fullyConsumedHorizontal := aState dX isZero not and: [
		infiniteElement layout canScrollHorizontally
			and: [ aState hResult = aState dX ] ].
		
	fullyConsumedVertical := aState dY isZero not and: [
		infiniteElement layout canScrollVertically
			and: [ aState vResult = aState dY ] ].
		
	fullyConsumedAny := aState dX isZero and: [
		aState dY isZero and: [
			fullyConsumedHorizontal or: [ fullyConsumedVertical ] ] ].
		
	(anOverScroller isFinished or: [ fullyConsumedAny not ])
		ifTrue: [ 
			infiniteElement scrollState: ScrollIdle.
			infiniteElement prefetchingAllowed
				ifTrue: [ self shouldBeImplemented ] ]
		ifFalse: [ 
			self postOnAnimation.
			infiniteElement prefetchingAllowed
				ifTrue: [ self shouldBeImplemented ] ]
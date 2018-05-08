private
runFinalizeOn: anOverScroller with: aState
	| fullyConsumedHorizontal fullyConsumedVertical fullyConsumedAny |
	
	fullyConsumedHorizontal := aState dX isZero not and: [
		self scrollable canScrollHorizontally
			and: [ aState hResult = aState dX ] ].
		
	fullyConsumedVertical := aState dY isZero not and: [
		self scrollable canScrollVertically
			and: [ aState vResult = aState dY ] ].
		
	fullyConsumedAny := aState dX isZero and: [
		aState dY isZero and: [
			fullyConsumedHorizontal or: [ fullyConsumedVertical ] ] ].
	
	(anOverScroller isFinished or: [ fullyConsumedHorizontal and: [ fullyConsumedVertical ] ])
		ifTrue: [
			self beIdle.
			self onFinished ]
		ifFalse: [
			self postOnAnimation.
			self onNotFinished ]
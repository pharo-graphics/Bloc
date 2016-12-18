hooks
onSeekTargetStep: aDeltaPoint action: aScrollerAction

	self childrenCount isZero
		ifTrue: [ ^ self stop ].
		
	(targetVector isNotNil and: [
		(targetVector x * aDeltaPoint x) < 0 or: [ 
			(targetVector y * aDeltaPoint y) < 0 ] ])
		ifTrue: [ self error: 'Scroll happened in the opposite direction of the target, check your calculations' ].
	
	interimTarget := (self clampApplyScroll: interimTarget x to: aDeltaPoint x) @ (self clampApplyScroll: interimTarget y to: aDeltaPoint y).
	
	interimTarget isZero
		ifTrue: [ self updateActionForInterimTarget: aScrollerAction ].

	"everything is valid, keep going"
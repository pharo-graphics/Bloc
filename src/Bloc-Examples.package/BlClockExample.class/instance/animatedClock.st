examples - clock
animatedClock
	<gtExample>
	| secondHand |

	secondHand := self secondHand.
	
	BlNumberTransition new
		onStepDo: [ :aSecond |
			secondHand transformDo: [ :aTransform |
				aTransform rotateBy: aSecond * self minuteRotationDelta - 90 ] ];
		from: 0;
		to: 60;
		by: 1;
		loop: 1;
		duration: 60 seconds;
		startOn: secondHand.

	^ self clock
		relocate: 50@50;
		addChildren: self hourTicks;
		addChildren: self minuteTicks;
		addChild: secondHand
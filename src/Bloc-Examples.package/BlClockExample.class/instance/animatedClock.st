examples - clock
animatedClock
	<gtExample>
	| secondHand |

	secondHand := self secondHand.
	
	animation := BlStepping new
		onStepDo: [ :aSecond |
			secondHand transformDo: [ :aTransform |
				aTransform rotateBy: (0 to: 60) atRandom * self minuteRotationDelta - 90 ] ];
		stepTime: 1 seconds;
		beInfinite;
		startOn: secondHand.

	^ self clock
		relocate: 50@50;
		addChildren: self hourTicks;
		addChildren: self minuteTicks;
		addChild: secondHand
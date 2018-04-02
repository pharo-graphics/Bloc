examples - clock
animatedClock
	<gtExample>
	| secondHand animation |

	secondHand := self secondHand.
	
	animation := BlNumberTransition new
		onStepDo: [ :aSecond |
			secondHand transformDo: [ :aTransform |
				aTransform rotateBy: aSecond * self minuteRotationDelta - 90 ] ];
		from: 0;
		to: 60;
		by: 1;
		loops: 1;
		duration: 60 seconds.
		
	secondHand addAnimation: animation.

	^ self clock
		relocate: 50@50;
		addChildren: self hourTicks;
		addChildren: self minuteTicks;
		addChild: secondHand
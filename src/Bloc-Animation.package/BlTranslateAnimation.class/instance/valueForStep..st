pulse
valueForStep: aDelta
	^  from + ((to x - from x) @ (to y - from y) * aDelta) asIntegerPoint
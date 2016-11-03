pulse
valueForStep: aDelta
	^ (((to x - from x)@(to y - from y)) * aDelta) asIntegerPoint + (from min:to)
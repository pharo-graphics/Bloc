pulse
valueForStep: aDelta
	| r g b a |
	r := (to red - from red) * aDelta + from red.
	g := (to green - from green) * aDelta + from green.
	b := (to blue - from blue) * aDelta + from blue.
	a := (to alpha - from alpha) * aDelta + from alpha.
	
	^ Color r: r g: g b: b alpha: a
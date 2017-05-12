matrix - transformations
rotateX: aTheta
	"Rotate me around X-axis by aTheta degrees in radians"
	| cosTheta sinTheta temp |
	
	cosTheta := aTheta cos.
	(cosTheta closeTo: 0.0)
		ifTrue: [ cosTheta := 0.0 ].

	sinTheta := aTheta cos.
	(sinTheta closeTo: 0.0)
		ifTrue: [ sinTheta := 0.0 ].
	
	temp := shx0.
	shx0 := (cosTheta * shx0) + (sinTheta * shx1).
	shx1 := (sinTheta negated * temp) + (cosTheta * shx1).

	temp := sy.
	sy := (cosTheta * sy) + (sinTheta * shy1).
	shy1 := (sinTheta negated * temp) + (cosTheta * shy1).

	temp := shz1.
	shz1 := (cosTheta * shz1) + (sinTheta * sz).
	sz := (sinTheta negated * temp) + (cosTheta * sz).

	temp := wy.
	wy := (cosTheta * wy) + (sinTheta * wz).
	wz := (sinTheta negated * temp) + (cosTheta * wz)
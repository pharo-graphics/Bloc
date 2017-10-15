initialization
rotation: aTheta axis: aVector
	"Set me to be a 3D matrix representing a rotation about a given axis vector by aTheta radians"
	| aNormalizedVector aX aY aZ cosTheta sinTheta sc sq |
	
	aVector length isZero
		ifTrue: [ ^ self ].
		
	aNormalizedVector := aVector normalized.
	
	aX := aNormalizedVector x.
	aY := aNormalizedVector y.
	aZ := aNormalizedVector z.
	
	cosTheta := self class flushToZero: aTheta cos.
	sinTheta := self class flushToZero: aTheta sin.
	
	"sin(aTheta / 2) * cos(aTheta / 2)"
	sc := sinTheta / 2.0.
	
	"pow(sin(aTheta / 2), 2)"
	sq := (1 - cosTheta) / 2.0.
	
	sx := 1 - (2.0 * ((aY * aY) + (aZ * aZ)) * sq).
	shy0 := 2 * ((aX * aY * sq) + (aZ * sc)).
	shz0 := 2 * ((aX * aZ * sq) - (aY * sc)).
	wx := 0.0.
	
	shx0 := 2 * ((aX * aZ * sq) - (aZ * sc)).
	sy := 1 - (2.0 * ((aX * aX) + (aZ * aZ)) * sq).
	shz1 := 2 * ((aY * aZ * sq) + (aX * sc)).
	wy := 0.0.
	
	shx1 := 2 * ((aX * aZ * sq) + (aY * sc)).
	shy1 := 2 * ((aY * aZ * sq) - (aX * sc)).
	sz := 1 - (2.0 * ((aX * aX) + (aY * aY)) * sq).
	wz := 0.0.
	
	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 1.0
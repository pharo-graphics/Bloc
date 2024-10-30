Extension { #name : #BlGradientShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	| newElementHash |
	newElementHash := self elementHashFor: aBlElement.
	(shadowSurface isNil or: [
		 shadowSurface isNull or: [
			 shadowSurfaceElementHash ~= newElementHash ] ])
		ifTrue: [
			shadowSurfaceElementHash := newElementHash.
			aBlElement geometry
				aeSetGradientShadowOn: self
				extent: aBlElement extent ].

	aeCanvas
		maskSurface: shadowSurface
		x: offset x - extraGap
		y: offset y - extraGap
		color: color
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> alphaBellFunctionAt: x [
	"Answer the evaluation of a number in a Gaussian bell function with mean=0.0 and stdev=1.0, whose peak a 0.0 results in 1.0."

	^ (x squared * -0.5) exp
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setShadowForCircle: radius [ 

	| aShadowContext aGradient shadowCenter rampSize |
	shadowSurface :=
		AeCairoImageSurface
			extent: ((radius + extraGap) * 2) asInteger asPoint
			format: AeCairoSurfaceFormat a8.
	aShadowContext := shadowSurface newContext.

	shadowCenter := (radius + extraGap) asPoint.
	rampSize := 10.

	aGradient :=
		AeCairoRadialGradientPattern
			innerCenter: shadowCenter
			innerRadius: radius - (width/1.5)
			outerCenter: shadowCenter
			outerRadius: radius + extraGap "(width*1.5)".

	"Start by full alpha channel. RGB channels don't matter
	as we are on an a8 surface"
	aGradient
		addStopAt: 0.0
		r: 1.0
		g: 1.0
		b: 1.0
		a: 1.0.

	"Interpolate alpha channel in base of Gaussian function"
	1 to: rampSize - 1 do: [ :i |
		| g |
		g := (i / rampSize) asFloat.
		aGradient
			addStopAt: g
			r: 1.0
			g: 1.0
			b: 1.0
			a: (self alphaBellFunctionAt: g * 4.0) ].

	"End with zero alpha channel"
	aGradient
		addStopAt: 1.0
		r: 1.0
		g: 1.0
		b: 1.0
		a: 0.0.

	aShadowContext
		source: aGradient;
		paint.

	shadowSurface status ensureIsSuccess
]

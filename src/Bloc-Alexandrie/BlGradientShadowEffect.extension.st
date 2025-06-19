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
BlGradientShadowEffect >> rampSize: rampSize stopsAndAlphasDo: aBlock [

	aBlock value: 0.0 value: 1.0.

	1 to: rampSize - 2 do: [ :i |
		| stop |
		stop := i / (rampSize - 1) asFloat.
		aBlock
			value: stop
			value: (self alphaBellFunctionAt: stop * 4.0) ].

	aBlock value: 1.0 value: 0.0
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setShadowForCircle: radius [ 

	| aShadowContext aGradient shadowCenter |
	shadowSurface :=
		AeCairoImageSurface
			extent: ((radius + extraGap) * 2) asInteger asPoint
			format: AeCairoSurfaceFormat a8.
	aShadowContext := shadowSurface newContext.

	shadowCenter := (radius + extraGap) asPoint.

	aGradient :=
		AeCairoRadialGradientPattern
			innerCenter: shadowCenter
			innerRadius: ((radius - (width / 1.5)) max: 0.0)
			outerCenter: shadowCenter
			outerRadius: ((radius + extraGap) max: 0.0).

	"Define all stops of alpha channel. RGB channels don't matter
	as we are on an a8 surface"
	self
		rampSize: width
		stopsAndAlphasDo: [ :eachStop :eachAlpha |
			aGradient
				addStopAt: eachStop
				r: 1.0
				g: 1.0
				b: 1.0
				a: eachAlpha ].

	aShadowContext
		source: aGradient;
		paint.

	shadowSurface status ensureIsSuccess
]

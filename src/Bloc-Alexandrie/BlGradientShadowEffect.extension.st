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
BlGradientShadowEffect >> gaussAt: x mean: mu stdev: sigma [

	| exponent |
	exponent := -0.5 * ((x - mu) / sigma) squared.
	
	^ (GaussK / sigma) * exponent exp
]

{ #category : #'*Bloc-Alexandrie' }
BlGradientShadowEffect >> setShadowForCircle: radius [ 

	| aShadowContext aGradient shadowCenter rampSize fix |
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

	"Start by full alpha channel. Other channel doesn't matter as it's an a8 surface"
	aGradient
		addStopAt: 0.0
		r: 1.0
		g: 1.0
		b: 1.0
		a: 1.0.

	"Interpolate alpha channel in base of Gaussian function"
	fix := self gaussAt: 0 mean: 0.0 stdev: 1.0.
	1 to: rampSize - 1 do: [ :i |
		| g |
		g := (i/rampSize) asFloat.
		aGradient
			addStopAt: g
			r: 1.0
			g: 1.0
			b: 1.0
			a: (self gaussAt: g * 4.0 mean: 0.0 stdev: 1.0) / fix ].

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

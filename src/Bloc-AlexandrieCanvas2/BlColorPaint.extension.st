Extension { #name : 'BlColorPaint' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlColorPaint >> asBABackgroundAlpha: backgroundOpacity [

	self haltIf: [backgroundOpacity notNil and: [backgroundOpacity < 1.0]].

	^ AeColorSource new color: color; yourself
]

{ #category : '*Bloc-AlexandrieCanvas2' }
BlColorPaint >> asBAStrokeSource [

	^ AeColorSource new color: color; yourself
]

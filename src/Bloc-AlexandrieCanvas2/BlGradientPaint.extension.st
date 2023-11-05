Extension { #name : 'BlGradientPaint' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlGradientPaint >> asBABackgroundAlpha: backgroundOpacity [

	self haltIf: [backgroundOpacity < 1.0].
	
	^ self newCairoPattern
]

{ #category : '*Bloc-AlexandrieCanvas2' }
BlGradientPaint >> newCairoPattern [
		
	^ self subclassResponsibility
]

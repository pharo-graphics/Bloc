Extension { #name : 'BlGradientPaint' }

{ #category : '*Bloc-Alexandrie' }
BlGradientPaint >> aeApplyAsBackgroundTo: aeCanvas opacity: backgroundOpacity [

	aeCanvas
		setBackgroundWith: [ self aeApplyTo: aeCanvas ]
		alpha: backgroundOpacity
]

Extension { #name : #BlGradientPaint }

{ #category : #'*Bloc-Alexandrie' }
BlGradientPaint >> aeApplyTo: aeCanvas opacity: backgroundOpacity [

	aeCanvas
		setBackgroundWith: [ self aeApplyTo: aeCanvas ]
		alpha: backgroundOpacity
]

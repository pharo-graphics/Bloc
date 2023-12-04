Extension { #name : 'BlColorPaint' }

{ #category : '*Bloc-Alexandrie' }
BlColorPaint >> aeApplyAsBackgroundTo: aeCanvas opacity: backgroundOpacity [

	self flag: #todo. "AeCanvas takes decisions based on alpha. Keep?"
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceSolidColor: color ]
		alpha: backgroundOpacity * color alpha
]

{ #category : '*Bloc-Alexandrie' }
BlColorPaint >> aeApplyTo: aeCanvas [
	
	aeCanvas setSourceColor: self color
]

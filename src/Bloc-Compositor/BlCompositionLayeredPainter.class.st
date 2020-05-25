Class {
	#name : #BlCompositionLayeredPainter,
	#superclass : #BlCompositionPainter,
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #testing }
BlCompositionLayeredPainter >> shouldCreateNewLayer: wantsCompositionLayer [
	^ false
]

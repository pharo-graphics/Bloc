Class {
	#name : 'BlCompositingWithoutLayerMode',
	#superclass : 'BlCompositingMode',
	#package : 'Bloc',
	#tag : 'Basic-Support'
}

{ #category : 'testing' }
BlCompositingWithoutLayerMode >> wantsBufferedLayer [
	^ false
]

{ #category : 'testing' }
BlCompositingWithoutLayerMode >> wantsCompositionLayer [
	^ false
]

Class {
	#name : 'BlCompositingWithoutLayerMode',
	#superclass : 'BlCompositingMode',
	#category : 'Bloc-Basic-Support',
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

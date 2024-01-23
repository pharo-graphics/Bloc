Class {
	#name : #BlCompositingWithoutLayerMode,
	#superclass : #BlCompositingMode,
	#category : 'Bloc-Basic-Support'
}

{ #category : #testing }
BlCompositingWithoutLayerMode >> wantsBufferedLayer [
	^ false
]

{ #category : #testing }
BlCompositingWithoutLayerMode >> wantsCompositionLayer [
	^ false
]

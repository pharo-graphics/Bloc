"
Render the whole element including its children on a single composition layer mode.
This may be useful for complex elements that rarely change, for example visualisations

"
Class {
	#name : #BlCompositingSingleLayerMode,
	#superclass : #BlCompositingWithLayerMode,
	#category : 'Bloc-Basic-Support'
}

{ #category : #testing }
BlCompositingSingleLayerMode >> wantsBufferedLayer [
	^ true
]

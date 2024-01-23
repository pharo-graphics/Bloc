Class {
	#name : #BlOutskirtsOutside,
	#superclass : #BlOutskirts,
	#category : 'Bloc-Basic-Border'
}

{ #category : #'visual bounds' }
BlOutskirtsOutside >> strokedBounds: aBlBounds of: anElement [

	^ anElement geometry strokedBoundsOutside: aBlBounds of: anElement
]

{ #category : #testing }
BlOutskirtsOutside >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	
	^ anElement border isVisible
]

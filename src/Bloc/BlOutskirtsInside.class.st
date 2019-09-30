Class {
	#name : #BlOutskirtsInside,
	#superclass : #BlOutskirts,
	#category : #'Bloc-Basic-Border'
}

{ #category : #'visual bounds' }
BlOutskirtsInside >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	^ anElement geometry strokedBoundsInside: aBlBounds of: anElement on: aCanvas
]

{ #category : #testing }
BlOutskirtsInside >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ anElement border isVisible
]

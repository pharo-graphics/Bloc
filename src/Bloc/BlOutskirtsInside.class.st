Class {
	#name : 'BlOutskirtsInside',
	#superclass : 'BlOutskirts',
	#package : 'Bloc',
	#tag : 'Basic-Border'
}

{ #category : 'visual bounds' }
BlOutskirtsInside >> strokedBounds: aBlBounds of: anElement [

	^ anElement geometry strokedBoundsInside: aBlBounds of: anElement
]

{ #category : 'testing' }
BlOutskirtsInside >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ anElement border isVisible
]

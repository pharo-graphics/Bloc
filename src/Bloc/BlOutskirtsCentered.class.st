Class {
	#name : #BlOutskirtsCentered,
	#superclass : #BlOutskirts,
	#category : #'Bloc-Basic-Border'
}

{ #category : #testing }
BlOutskirtsCentered >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ anElement border isTransparent not
]

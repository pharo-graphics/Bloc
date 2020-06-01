"
! Hello 2
"
Class {
	#name : #BlExampleElementThatWantsCompositionLayer,
	#superclass : #BlElement,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'as yet unclassified' }
BlExampleElementThatWantsCompositionLayer >> fullPaintOn: aCompositorPainter offset: anOffset [
	super fullPaintOn: aCompositorPainter offset: anOffset
]

{ #category : #testing }
BlExampleElementThatWantsCompositionLayer >> wantsCompositionLayer [
	^ true
]

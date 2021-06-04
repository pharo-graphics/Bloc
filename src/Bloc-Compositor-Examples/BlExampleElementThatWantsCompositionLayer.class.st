"
# Hello 2

"
Class {
	#name : #BlExampleElementThatWantsCompositionLayer,
	#superclass : #BlElement,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #initialization }
BlExampleElementThatWantsCompositionLayer >> initialize [
	super initialize.
	
	self beInSeparateCompositionLayer
]

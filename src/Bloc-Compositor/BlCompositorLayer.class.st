"
I represent a layer in a composition tree that can be rendered on sparta canvas and contains rendering nodes with similar properties (for examples node of the same elevation)


"
Class {
	#name : #BlCompositorLayer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Compositor'
}

{ #category : #drawing }
BlCompositorLayer >> drawOnSpartaCanvas: aCanvas [
	self subclassResponsibility
]

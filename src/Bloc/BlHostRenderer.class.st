"
Host renderer is resposible for the overall rendering logic.


"
Class {
	#name : #BlHostRenderer,
	#superclass : #Object,
	#traits : 'TBlHostRenderer',
	#classTraits : 'TBlHostRenderer classTrait',
	#instVars : [
		'surface',
		'surfaceRenderer',
		'spaceRenderer'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #'instance creation' }
BlHostRenderer class >> forHostSpace: aHostSpace [
	^ self basicNew
		initialize;
		initializeForHostSpace: aHostSpace
]

{ #category : #initialization }
BlHostRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	self subclassResponsibility
]

"
I define the strategy to be used to draw the border (inside/outside/centered)
"
Class {
	#name : #BlOutskirts,
	#superclass : #Object,
	#classVars : [
		'Centered',
		'Inside',
		'Outside'
	],
	#category : #'Bloc-Basic-Border'
}

{ #category : #'predefined instances' }
BlOutskirts class >> centered [
	^ Centered ifNil: [ Centered := BlOutskirtsCentered new ]
]

{ #category : #cleanup }
BlOutskirts class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	Centered := Inside := Outside := nil
]

{ #category : #'predefined instances' }
BlOutskirts class >> inside [
	^ Inside ifNil: [ Inside := BlOutskirtsInside new  ]
]

{ #category : #'predefined instances' }
BlOutskirts class >> outside [
	^ Outside ifNil: [ Outside := BlOutskirtsOutside new ]
]

{ #category : #comparing }
BlOutskirts >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlOutskirts >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #testing }
BlOutskirts >> wantsLayerOn: anElement [
	"Return true if background and border should be rendered on a separate layer,
	false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

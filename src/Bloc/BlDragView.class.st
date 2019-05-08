Class {
	#name : #BlDragView,
	#superclass : #BlElement,
	#instVars : [
		'target'
	],
	#category : #'Bloc-Space-Support'
}

{ #category : #'as yet unclassified' }
BlDragView class >> on: aForm [
	^ self new target: aForm
]

{ #category : #initialization }
BlDragView >> initialize [
	super initialize.
	self border: (BlBorder paint: Color veryLightGray width: 1).
	self background: (Color white).
	self effect: (BlDropShadowEffect new color: Color gray; width: 2; offset:2@2)
]

{ #category : #accessing }
BlDragView >> target [
	^ target
]

{ #category : #accessing }
BlDragView >> target: aForm [
	target := aForm asForm. 
	
	self extent: target extent.
]

{ #category : #'as yet unclassified' }
BlDragView >> updateFromCursorPosition: aPosition [
	self position: aPosition - (self extent / 2)
]

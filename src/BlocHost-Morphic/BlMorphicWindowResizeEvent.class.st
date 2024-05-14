"
I am fired when host window changed its size
"
Class {
	#name : #BlMorphicWindowResizeEvent,
	#superclass : #BlMorphicWindowEvent,
	#instVars : [
		'width',
		'height'
	],
	#category : #'BlocHost-Morphic-Common - Events'
}

{ #category : #accessing }
BlMorphicWindowResizeEvent >> height [
	^ height
]

{ #category : #accessing }
BlMorphicWindowResizeEvent >> height: anObject [
	height := anObject
]

{ #category : #dispatching }
BlMorphicWindowResizeEvent >> sentTo:anObject [
	"Dispatch the receiver into anObject"
	^anObject handleWindowResize: self.
]

{ #category : #accessing }
BlMorphicWindowResizeEvent >> type [
	^ #windowResize
]

{ #category : #accessing }
BlMorphicWindowResizeEvent >> width [
	^ width
]

{ #category : #accessing }
BlMorphicWindowResizeEvent >> width: anObject [
	width := anObject
]

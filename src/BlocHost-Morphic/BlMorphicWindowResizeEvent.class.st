"
I am fired when host window changed its size
"
Class {
	#name : #BlMorphicWindowResizeEvent,
	#superclass : #WindowEvent,
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

{ #category : #accessing }
BlMorphicWindowResizeEvent >> position [
	"Since cursorPoint is defined and refers to position it should be defined
	here as well"

	^ 0 @ 0
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

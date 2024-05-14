"
I am fired by morphic host window when it is opened in the World
"
Class {
	#name : #BlMorphicWindowOpenedEvent,
	#superclass : #BlMorphicWindowEvent,
	#category : #'BlocHost-Morphic-Common - Events'
}

{ #category : #dispatching }
BlMorphicWindowOpenedEvent >> sentTo:anObject [
	"Dispatch the receiver into anObject"
	^anObject handleWindowOpened: self.
]

{ #category : #accessing }
BlMorphicWindowOpenedEvent >> type [
	^ #windowShow
]

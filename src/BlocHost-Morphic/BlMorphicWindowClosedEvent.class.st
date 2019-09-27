"
I am fired by morphic host window when it is closed or deleted from the World
"
Class {
	#name : #BlMorphicWindowClosedEvent,
	#superclass : #BlMorphicWindowEvent,
	#category : 'BlocHost-Morphic-Events'
}

{ #category : #dispatching }
BlMorphicWindowClosedEvent >> sentTo:anObject [
	"Dispatch the receiver into anObject"
	^anObject handleWindowClosed: self.
]

{ #category : #accessing }
BlMorphicWindowClosedEvent >> type [
	^ #windowClosed
]

Class {
	#name : #BlLayoutResizerChangedEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Layout-Resizer'
}

{ #category : #sending }
BlLayoutResizerChangedEvent >> sendTo: anObject [

	anObject layoutResizerChangedEvent: self
]

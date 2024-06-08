Class {
	#name : #BlLayoutConstraintsChangedEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Layout-Resizer'
}

{ #category : #sending }
BlLayoutConstraintsChangedEvent >> sendTo: anObject [

	anObject layoutConstraintsChangedEvent: self
]

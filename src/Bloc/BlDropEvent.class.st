"
The `BlDropEvent` event is fired when a pointing device drop an element
"
Class {
	#name : #BlDropEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDropEvent >> sendTo: anObject [
	anObject dropEvent: self
]

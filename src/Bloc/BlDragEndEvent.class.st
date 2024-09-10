"
The `BlDragEndEvent` event is fired when an element is being drop, to indicate the end of drag move. It is fired after the `BlDropEvent`
"
Class {
	#name : #BlDragEndEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragEndEvent >> sendTo: anObject [
	anObject dragEndEvent: self
]

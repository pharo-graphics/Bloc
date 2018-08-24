"
The mouse over event is fired when a pointing device is moved onto the element that has the listener attached or onto one of its children.

Similar to mouse enter, it differs in that it bubbles and that it is sent when the pointer is moved from one of its descendants' physical space to its own physical space.

https://developer.mozilla.org/en-US/docs/Web/Events/mouseover
"
Class {
	#name : #BlMouseOverEvent,
	#superclass : #BlMouseEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlMouseOverEvent >> sendTo: anObject [
	anObject mouseOverEvent: self
]

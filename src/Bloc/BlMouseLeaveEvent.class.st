"
The mouse leave event is fired when the pointer of a pointing device (usually a mouse) is moved out of an element.

Mouse leave and mouse out are similar but differ in that mouse leave does not bubble and mouse out does.
This means that mouse leave is fired when the pointer has exited the element and all of its descendants, whereas mouse out is fired when the pointer leaves the element or leaves one of the element's descendants (even if the pointer is still within the element).

See `BlMouseOverOutAndEnterLeaveEventExplanation` to learn more about the difference with `BlMouseOutEvent`

https://developer.mozilla.org/en-US/docs/Web/Events/mouseleave

"
Class {
	#name : #BlMouseLeaveEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlMouseLeaveEvent >> isMouseLeave [
	^ true
]

{ #category : #sending }
BlMouseLeaveEvent >> sendTo: anObject [
	anObject mouseLeaveEvent: self
]

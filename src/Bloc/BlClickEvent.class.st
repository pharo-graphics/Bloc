"
The click event is fired when a pointing device button (a mouse's primary button) is pressed and released on a single element.

The order of fired events:

 - Mouse Down
 - Mouse Up
 - Click
"
Class {
	#name : #BlClickEvent,
	#superclass : #BlMouseEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlClickEvent >> isClick [
	^ true
]

{ #category : #sending }
BlClickEvent >> sendTo: anObject [
	anObject clickEvent: self
]

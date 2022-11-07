"
The mouse up somewhere event is fired in case of a mouse up occuring outside the element where the mouse up occured. It is useful to know how to dress a button when a mouse up is fired outside the button whereas a mouse down occured in the button.
"
Class {
	#name : #BlMouseUpSomewhereEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlMouseUpSomewhereEvent >> sendTo: anObject [
	anObject mouseUpSomewhereEvent: self
]

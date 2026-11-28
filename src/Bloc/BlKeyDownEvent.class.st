Class {
	#name : #BlKeyDownEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'isRepeated'
	],
	#category : #'Bloc-Events'
}

{ #category : #initialization }
BlKeyDownEvent >> initialize [

	super initialize.

	isRepeated := false
]

{ #category : #accessing }
BlKeyDownEvent >> isRepeated [

	^ isRepeated
]

{ #category : #accessing }
BlKeyDownEvent >> isRepeated: aBoolean [

	isRepeated := aBoolean
]

{ #category : #sending }
BlKeyDownEvent >> sendTo: anObject [
	anObject keyDownEvent: self
]

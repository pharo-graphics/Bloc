Class {
	#name : #BlKeyUpEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'key'
	],
	#category : #'Bloc-Events'
}

{ #category : #'key - accessing' }
BlKeyUpEvent >> key [
	^ key
]

{ #category : #'key - accessing' }
BlKeyUpEvent >> key: anObject [
	key := anObject
]

{ #category : #printing }
BlKeyUpEvent >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPut:$(;
		nextPutAll:'key: ';
		print: key;
		nextPutAll:'position: ';
		print: position;
		nextPutAll:'; screenPosition: ';
		print: screenPosition;
		nextPutAll:'; modifiers: ';
		print: modifiers;
		nextPutAll:'; button: ';
		print: button;
		nextPut:$)
]

{ #category : #sending }
BlKeyUpEvent >> sendTo: anObject [
	anObject keyUpEvent: self
]

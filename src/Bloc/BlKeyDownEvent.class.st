Class {
	#name : #BlKeyDownEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'key'
	],
	#category : 'Bloc-Event'
}

{ #category : #'key - accessing' }
BlKeyDownEvent >> key [
	^ key
]

{ #category : #'key - accessing' }
BlKeyDownEvent >> key: anObject [
	key := anObject
]

{ #category : #printing }
BlKeyDownEvent >> printOn: aStream [
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
BlKeyDownEvent >> sendTo: anObject [
	anObject keyDownEvent: self
]

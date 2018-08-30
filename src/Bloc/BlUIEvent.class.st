Class {
	#name : #BlUIEvent,
	#superclass : #BlEvent,
	#instVars : [
		'position',
		'screenPosition',
		'modifiers',
		'button'
	],
	#category : 'Bloc-Event'
}

{ #category : #accessing }
BlUIEvent >> button [
	^ button
]

{ #category : #accessing }
BlUIEvent >> button: anObject [
	button := anObject
]

{ #category : #initialization }
BlUIEvent >> initialize [
	super initialize.
	modifiers := BlKeyModifiers new.
]

{ #category : #'api - geometry' }
BlUIEvent >> localPosition [
	"Return an event position in local coordinates of a #currentTarget"
	<return: #Point>
	
	^ self currentTarget globalPointToLocal: self position
]

{ #category : #accessing }
BlUIEvent >> modifiers [
	<return: #BlKeyModifiers>

	^ modifiers
]

{ #category : #accessing }
BlUIEvent >> modifiers: aBlKeyModifiers [
	 modifiers := aBlKeyModifiers
]

{ #category : #'api - geometry' }
BlUIEvent >> position [
	^ position
]

{ #category : #accessing }
BlUIEvent >> position: anObject [
	position := anObject
]

{ #category : #printing }
BlUIEvent >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPut:$(;
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

{ #category : #'api - geometry' }
BlUIEvent >> screenPosition [
	^ screenPosition
]

{ #category : #accessing }
BlUIEvent >> screenPosition: anObject [
	screenPosition := anObject
]

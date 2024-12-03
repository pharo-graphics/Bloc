Class {
	#name : #BlMouseEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'position',
		'screenPosition',
		'button',
		'delta'
	],
	#category : #'Bloc-Events'
}

{ #category : #constants }
BlMouseEvent class >> anyButton [
	^ 7
]

{ #category : #testing }
BlMouseEvent >> anyButtonPressed [
	^ button isNotNil
]

{ #category : #converting }
BlMouseEvent >> asClickEvent [
	^ self button clickEventClass new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDictionaryForExport [
	^ super asDictionaryForExport
		at: #position put: position printString;
		at: #screenPosition put: screenPosition printString;
		at: #button put: button printString;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDragEndEvent [
	
	^ BlDragEndEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDragEnterEvent [
	"Convert the receiver into a mouse move"

	^ BlDragEnterEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDragEvent [
	^ BlDragEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDragLeaveEvent [
	"Convert the receiver into a mouse move"

	^ BlDragLeaveEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDragStartEvent [
	"Convert the receiver into a mouse move"

	^ BlDragStartEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlMouseEvent >> asDropEvent [
	^ BlDropEvent new
		copyFrom: self;
		yourself
]

{ #category : #testing }
BlMouseEvent >> asMouseEnterEvent [
	^ BlMouseEnterEvent new
		copyFrom: self;
		yourself
]

{ #category : #testing }
BlMouseEvent >> asMouseLeaveEvent [
	^ BlMouseLeaveEvent new
		copyFrom: self;
		yourself
]

{ #category : #testing }
BlMouseEvent >> asMouseOutEvent [
	^ BlMouseOutEvent new
		copyFrom: self;
		yourself
]

{ #category : #testing }
BlMouseEvent >> asMouseOverEvent [
	^ BlMouseOverEvent new
		copyFrom: self;
		yourself
]

{ #category : #accessing }
BlMouseEvent >> button [
	<return: #BlMouseButton>

	^ button
]

{ #category : #accessing }
BlMouseEvent >> button: aBlMouseButton [
	button := aBlMouseButton
]

{ #category : #testing }
BlMouseEvent >> canFindTargetFrom: anElement [

	^ false
]

{ #category : #accessing }
BlMouseEvent >> delta [
	^ delta
]

{ #category : #accessing }
BlMouseEvent >> delta: aPoint [
	delta := aPoint
]

{ #category : #processing }
BlMouseEvent >> findTargetFrom: aSpaceOrElement [

	^ (aSpaceOrElement findMouseEventTargetAt: self position) ifNil: [
		  aSpaceOrElement space root ]
]

{ #category : #'action dispatching' }
BlMouseEvent >> ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock [

	^ self button ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock
]

{ #category : #testing }
BlMouseEvent >> isMouse [
	^ true
]

{ #category : #'api - geometry' }
BlMouseEvent >> localPosition [
	"Return an event position in local coordinates of a #currentTarget"
	<return: #Point>
	
	^ self currentTarget globalPointToLocal: self position
]

{ #category : #testing }
BlMouseEvent >> middleButtonPressed [
	^ button = BlMouseButton middle
]

{ #category : #'api - geometry' }
BlMouseEvent >> parentPosition [
	"Return an event position in parent coordinates of a #currentTarget"
	<return: #Point>
	
	^ self currentTarget globalPointToParent: self position
]

{ #category : #'api - geometry' }
BlMouseEvent >> position [
	^ position
]

{ #category : #accessing }
BlMouseEvent >> position: anObject [
	position := anObject
]

{ #category : #testing }
BlMouseEvent >> primaryButtonPressed [
	^ button = BlMouseButton primary
]

{ #category : #printing }
BlMouseEvent >> printOn: aStream [
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
BlMouseEvent >> screenPosition [
	^ screenPosition
]

{ #category : #accessing }
BlMouseEvent >> screenPosition: anObject [
	screenPosition := anObject
]

{ #category : #testing }
BlMouseEvent >> secondaryButtonPressed [
	^ button = BlMouseButton secondary
]

{ #category : #sending }
BlMouseEvent >> sendTo: anObject [
	anObject mouseEvent: self
]

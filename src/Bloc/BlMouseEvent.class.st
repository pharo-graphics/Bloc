Class {
	#name : #BlMouseEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'delta'
	],
	#category : #'Bloc-Events'
}

{ #category : #constants }
BlMouseEvent class >> anyButton [
	^ 7
]

{ #category : #constants }
BlMouseEvent class >> middleButton [
	self 
		deprecated: 'Use `BlMouseButton middle` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton middle
]

{ #category : #constants }
BlMouseEvent class >> primaryButton [
	self 
		deprecated: 'Use `BlMouseButton primary` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton primary
]

{ #category : #constants }
BlMouseEvent class >> secondaryButton [
	self 
		deprecated: 'Use `BlMouseButton secondary` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton secondary
]

{ #category : #testing }
BlMouseEvent >> anyButtonPressed [
	^ button isNotNil
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
BlMouseEvent >> asDragOverEvent [
	^ BlDragOverEvent new
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
BlMouseEvent >> delta [
	^ delta
]

{ #category : #accessing }
BlMouseEvent >> delta: anObject [
	delta := anObject
]

{ #category : #testing }
BlMouseEvent >> isMouse [
	^ true
]

{ #category : #testing }
BlMouseEvent >> middleButtonPressed [
	^ button = BlMouseButton middle
]

{ #category : #testing }
BlMouseEvent >> primaryButtonPressed [
	^ button = BlMouseButton primary
]

{ #category : #testing }
BlMouseEvent >> secondaryButtonPressed [
	^ button = BlMouseButton secondary
]

{ #category : #sending }
BlMouseEvent >> sendTo: anObject [
	anObject mouseEvent: self
]

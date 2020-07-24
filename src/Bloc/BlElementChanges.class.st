"
! Element change logger and processor

I log changes of various element properties during one frame.

 
"
Class {
	#name : #BlElementChanges,
	#superclass : #Object,
	#instVars : [
		'extentChange',
		'positionChange',
		'isDirty'
	],
	#category : #'Bloc-Basic-Changes'
}

{ #category : #enumeration }
BlElementChanges >> changes [
	"Return a collection of all changes"
	<return: #Array of: #BlElementChange>
	
	^ { positionChange . extentChange }
]

{ #category : #enumeration }
BlElementChanges >> changesDo: aBlock [
	"Evaluate a given block with every existing change as an argument"
	
	aBlock value: positionChange.
	aBlock value: extentChange
]

{ #category : #committing }
BlElementChanges >> commitOn: anElement [
	"Commit all accumulated changes done to the given element.
	As the result, all changes are marked as comitted"
	
	isDirty
		ifFalse: [ ^ self ].

	self changesDo: [ :aChange |
		anElement telemetry
			timeSync: [ 'Commit ', aChange class name ]
			during: [ aChange commitOn: anElement ] ].
	
	isDirty := false
]

{ #category : #'api - changes' }
BlElementChanges >> extentChange: anOldExtent to: aNewExtent [
	"Log the extent change of the element"

	extentChange old: anOldExtent new: aNewExtent.
	isDirty := true
]

{ #category : #initialization }
BlElementChanges >> initialize [
	super initialize.
	
	extentChange := BlElementExtentChange new.
	positionChange := BlElementPositionChange new.
	isDirty := true
]

{ #category : #testing }
BlElementChanges >> isExtentChanged [
	<return: #Boolean>

	^ extentChange hasActiveChanges
]

{ #category : #testing }
BlElementChanges >> isPositionChanged [
	<return: #Boolean>

	^ positionChange hasActiveChanges
]

{ #category : #'api - changes' }
BlElementChanges >> positionChange: anOldPosition to: aNewPosition [
	"Log the position change of the element"

	positionChange old: anOldPosition new: aNewPosition.
	isDirty := true
]

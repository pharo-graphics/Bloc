"
I represent a single element property change.

I log all changes in a linked list in order to simplify debugging process
"
Class {
	#name : #BlElementChange,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'records',
		'hasActiveChanges',
		'previousValue'
	],
	#category : #'Bloc-Basic-Changes'
}

{ #category : #'instance creation' }
BlElementChange class >> epsilon [
	^ 0.01
]

{ #category : #notifying }
BlElementChange >> commitChange: anNewValue on: anElement [
	"Send an event letting element's event handlers know that a property changed.
	Should be done once"
	
	self subclassResponsibility
]

{ #category : #notifying }
BlElementChange >> commitOn: anElement [
	"Commit changes done to the given element if there are any"
	| lastValue |

	self hasActiveChanges
		ifFalse: [ ^ self ].

	lastValue := records last changedValue.

	(previousValue isNil or: [ (self compare: lastValue with: previousValue) not ])
		ifTrue: [
			records last beNotified.
			self commitChange: lastValue on: anElement ].

	previousValue := lastValue.
	hasActiveChanges := false
]

{ #category : #comparing }
BlElementChange >> compare: aNewValue with: anOldValue [
	"Return true if new value is equal (or close to) to new value"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #printing }
BlElementChange >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #testing }
BlElementChange >> hasActiveChanges [
	"Return true if there are any uncomitted changes, false otherwise"
	<return: #Boolean>
	
	^ hasActiveChanges
]

{ #category : #initialization }
BlElementChange >> initialize [
	super initialize.
	
	records := LinkedList new.
	hasActiveChanges := false
]

{ #category : #accessing }
BlElementChange >> name [
	"Return a change name, eg. `Position` or `Extent` to be used in various tools extensions"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlElementChange >> newChangeValue: anObject [

	^ Bloc debugModeEnabled
		ifTrue: [ BlElementChangeRecordWithContext new changedValue: anObject; context: thisContext copyStack ]
		ifFalse: [ BlElementChangeRecord new changedValue: anObject ]
]

{ #category : #recording }
BlElementChange >> old: anOldValue new: aNewValue [
	self
		assert: [ records isEmpty or: [ self compare: records last changedValue with: anOldValue ] ]
		description: [ 'Last recorded value must be equal to the old value that is being changed' ].
	self
		assert: [ (self compare: anOldValue with: aNewValue) not ]
		description: [ 'Old and new values must be different' ].

	self records
		ifEmpty: [ self records add: (self newChangeValue: anOldValue) ].

	self records add: (self newChangeValue: aNewValue).
	hasActiveChanges := true
]

{ #category : #accessing }
BlElementChange >> previousValue [
	"Return last comitted value or nil if it does not exist"
	<return: #Object or: nil>

	^ previousValue
]

{ #category : #printing }
BlElementChange >> printOn: aStream [
	aStream nextPutAll: self name, ' (older values on top)'
]

{ #category : #accessing }
BlElementChange >> records [
	"Return a collection of all change records.
	It is not guaranteed that records collection contains
	absolutely all changes done to the element"
	<return: #Collection of: #BlElementChangeRecord>

	^ records
]

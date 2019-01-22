"
I represent a text selection defined as interval [from...to]
"
Class {
	#name : #BlSelection,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'empty'
	],
	#category : 'Bloc-Utilities - Selection'
}

{ #category : #cleanup }
BlSelection class >> cleanUp [
	super cleanUp.
	
	empty := nil
]

{ #category : #'instance creation' }
BlSelection class >> empty [
	^ empty ifNil: [ empty := BlEmptySelection new ]
]

{ #category : #'instance creation' }
BlSelection class >> from: aFromIndex to: aToIndex [
	^ BlMonotoneSelection from: aFromIndex to: aToIndex
]

{ #category : #arithmetic }
BlSelection >> + aTextSelection [
	^ BlMultipleSelection withAll: { self . aTextSelection }
]

{ #category : #accessing }
BlSelection >> allSelections [
	"Return a collection of all monotone selection intervals within this selection"
	<return: #Collection of: #BlMonotoneSelection>
	
	^ Array streamContents: [ :aStream | self do: [ :aSelection | aStream nextPut: aSelection ] ]
]

{ #category : #'api - enumerating' }
BlSelection >> anySatisfy: aBlock [
	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns true for any element return true.
	Otherwise return false."

	self do: [:each | (aBlock value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
BlSelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
BlSelection >> do: aBlock [
	"Evaluate a given block with all recorded selection intervals"
	
	self subclassResponsibility
]

{ #category : #'api - testing' }
BlSelection >> isEmpty [
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlSelection >> isNotEmpty [
	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
BlSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	self subclassResponsibility
]

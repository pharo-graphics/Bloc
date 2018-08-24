"
I am just a collection of independent text selections that may overlap.
"
Class {
	#name : #BlMultipleSelection,
	#superclass : #BlSelection,
	#instVars : [
		'selections'
	],
	#category : 'Bloc-Utilities - Selection'
}

{ #category : #'instance creation' }
BlMultipleSelection class >> withAll: aCollectionOfSelections [

	^ self new withAll: aCollectionOfSelections
]

{ #category : #arithmetic }
BlMultipleSelection >> + aSelection [
	^ self add: aSelection
]

{ #category : #adding }
BlMultipleSelection >> add: aSelection [
	selections add: aSelection
]

{ #category : #'api - testing' }
BlMultipleSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ selections anySatisfy: [ :eachSelection | 
		eachSelection contains: anIndex ]
]

{ #category : #'api - enumerating' }
BlMultipleSelection >> do: aBlock [
	selections do: [ :aSelection | aSelection do: aBlock ]
]

{ #category : #accessing }
BlMultipleSelection >> from [
	"Return a text index of the first selected character"
	<return: #Number>

	^ ((self selections select: [ :each | each isNotEmpty ])
		detectMin: [ :each | each from ]) from
]

{ #category : #'api - testing' }
BlMultipleSelection >> includes: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #initialization }
BlMultipleSelection >> initialize [
	super initialize.
	
	selections := OrderedCollection new
]

{ #category : #'api - testing' }
BlMultipleSelection >> isEmpty [
	^ selections allSatisfy: #isEmpty
]

{ #category : #'api - testing' }
BlMultipleSelection >> isNotEmpty [
	^ selections anySatisfy: #isNotEmpty
]

{ #category : #'api - enumerating' }
BlMultipleSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	selections reverseDo: [ :aSelection | aSelection do: aBlock ]
]

{ #category : #accessing }
BlMultipleSelection >> selections [
	^ selections
]

{ #category : #accessing }
BlMultipleSelection >> to [
	"Return a text index of the last selected character"
	<return: #Number>

	^ ((self selections select: [ :each | each isNotEmpty ])
			detectMax: [ :each | each to ]) to
]

{ #category : #initialization }
BlMultipleSelection >> withAll: aCollectionOfSelections [
	selections addAll: aCollectionOfSelections
]

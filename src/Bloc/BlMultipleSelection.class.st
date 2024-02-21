"
I am just a collection of independent text selections that may overlap.

"
Class {
	#name : #BlMultipleSelection,
	#superclass : #BlSelection,
	#instVars : [
		'selections'
	],
	#category : #'Bloc-Utilities - Selection'
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

{ #category : #accessing }
BlMultipleSelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ selections
]

{ #category : #'api - testing' }
BlMultipleSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	
	^ selections anySatisfy: [ :eachSelection | 
		eachSelection contains: anIndex ]
]

{ #category : #'api - testing' }
BlMultipleSelection >> containsIndex: anIndex [
	"Return true if selection indices include a given index, false otherwise.
	I am conceptually same as (self indices includes: anIndex)"

	
	^ selections anySatisfy: [ :eachSelection | 
		eachSelection contains: anIndex ]
]

{ #category : #'api - testing' }
BlMultipleSelection >> containsMonotoneSelection: aSelection [
	"Return true if selection interval include a given interval, false otherwise. "

	^ selections anySatisfy: [ :eachSelection | 
		eachSelection containsMonotoneSelection: aSelection ]
]

{ #category : #copying }
BlMultipleSelection >> copyFrom: aStartIndex to: anEndIndex [
	| newSelectionsSet newSelection |
	
	newSelectionsSet := selections
		collect: [ :eachSelection | eachSelection copyFrom: aStartIndex to: anEndIndex ]
		as: Set.
		
	newSelection := self class new.
	newSelectionsSet do: [ :eachSelection | newSelection add: eachSelection ].
	^ newSelection
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

{ #category : #copying }
BlMultipleSelection >> postCopy [
	selections := selections collect: [ :eachSelection | eachSelection copy ]
]

{ #category : #'api - enumerating' }
BlMultipleSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	selections reverseDo: [ :aSelection | aSelection do: aBlock ]
]

{ #category : #accessing }
BlMultipleSelection >> selections [
	<return: #Collection of: #BlSelection>

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

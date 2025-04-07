"
I am a composite text selection consisting of multiple independent non-overlapping monotone text selections.

"
Class {
	#name : #BlCompositeSelection,
	#superclass : #BlSelection,
	#instVars : [
		'selections'
	],
	#category : #'Bloc-Utilities - Selection'
}

{ #category : #'instance creation' }
BlCompositeSelection class >> fromIndices: aCollectionOfIndices [
	| aBlSelection |
	
	aBlSelection := self new.
	aCollectionOfIndices do: [ :eachIndex |
		aBlSelection select: eachIndex - 1 to: eachIndex ].
	
	^ aBlSelection
]

{ #category : #comparing }
BlCompositeSelection >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self selections = anObject selections
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> add: aMonotoneTextSelection [
	selections insert: aMonotoneTextSelection
]

{ #category : #accessing }
BlCompositeSelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ #()
]

{ #category : #'api - testing' }
BlCompositeSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	
	^ selections contains: anIndex
]

{ #category : #'api - testing' }
BlCompositeSelection >> containsIndex: anIndex [
	"Return true if selection indices include a given index, false otherwise.
	I am conceptually same as (self indices includes: anIndex)"
	
	^ selections containsIndex: anIndex
]

{ #category : #'api - testing' }
BlCompositeSelection >> containsInterval: anInterval [
	"Return true if selection  include a given interval, false otherwise "

	^ selections containsMonotoneSelection: (BlMonotoneSelection
			   from: (anInterval first min: anInterval last)
			   to: (anInterval first max: anInterval last))
]

{ #category : #'api - testing' }
BlCompositeSelection >> containsMonotoneSelection: aSelection [
	"Return true if selection  include a given monotone selection , false otherwise "
	
	^ selections containsMonotoneSelection: aSelection
]

{ #category : #copying }
BlCompositeSelection >> copyFrom: aStartIndex to: anEndIndex [
	| aNewSelection |
	
	aNewSelection := self class new.
	self do: [ :eachMonotoneSelection |
		aNewSelection select: (eachMonotoneSelection copyFrom: aStartIndex to: anEndIndex) ].
	
	^ aNewSelection
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselect: aSelection [
	"Remove a given selection"

	aSelection do: [ :aMonotoneSelection | self remove: aMonotoneSelection ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselect: aFromIndex to: aToIndex [
	"Remove a monotone selection within provided indices"
	
	self remove: (BlSelection from: aFromIndex to: aToIndex)
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselectAll [
	"Remove all "

	self reverseDo: [ :aMonotoneSelection |
		self deselect: aMonotoneSelection from to: aMonotoneSelection to ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselectIndex: anIndex [
	"Remove a given selection"

	self deselect: anIndex - 1 to: anIndex
]

{ #category : #'api - selection' }
BlCompositeSelection >> deselectIndexes: aCollection [

	aCollection do: [ :idx | self deselectIndex: idx ]
]

{ #category : #'api - enumerating' }
BlCompositeSelection >> do: aBlock [
	selections do: aBlock
]

{ #category : #'api - accessing' }
BlCompositeSelection >> from [
	"Return the minimum selected index which is the `from` index of the first sub-selection"
	<return: #Number>

	^ selections first selection from
]

{ #category : #comparing }
BlCompositeSelection >> hash [
	^ self class hash bitXor: self selections hash
]

{ #category : #'api - testing' }
BlCompositeSelection >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
    unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #'api - testing' }
BlCompositeSelection >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise"
	"If the notEmptyBlock has an argument, eval with the receiver as its argument"

	^ self isEmpty
		ifTrue: [ emptyBlock value ]
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'api - testing' }
BlCompositeSelection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
    unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #initialization }
BlCompositeSelection >> initialize [
	super initialize.
	
	selections := BlSelectionTree new
]

{ #category : #'api - testing' }
BlCompositeSelection >> isEmpty [
	^ selections isEmpty
]

{ #category : #'api - testing' }
BlCompositeSelection >> isNotEmpty [
	^ selections isNotEmpty
]

{ #category : #copying }
BlCompositeSelection >> postCopy [
	selections := selections copy
]

{ #category : #printing }
BlCompositeSelection >> printOn: aStream [
	selections printOn: aStream
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> remove: aMonotoneTextSelection [
	selections delete: aMonotoneTextSelection
]

{ #category : #'private - adding / removing' }
BlCompositeSelection >> removeAll [
	selections := BlSelectionTree new
]

{ #category : #'api - enumerating' }
BlCompositeSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	selections reverseDo: aBlock
]

{ #category : #'api - selection' }
BlCompositeSelection >> select: aSelection [
	"Add a given selection"

	aSelection do: [ :aMonotoneSelection | self add: aMonotoneSelection ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> select: aFromIndex to: aToIndex [
	"Add a new monotone selection merging it with existing ones within provided indices"
	
	self add: (BlSelection from: (aFromIndex max: 0) to: aToIndex)
]

{ #category : #'api - selection' }
BlCompositeSelection >> selectIndex: anIndex [
	"add a given selection"

	self select: anIndex - 1 to: anIndex
]

{ #category : #'api - selection' }
BlCompositeSelection >> selectIndexes: aCollection [

	aCollection do: [ :idx | self selectIndex: idx ]
]

{ #category : #'api - selection' }
BlCompositeSelection >> selectOnlyIndex: anIndex [

	self deselectAll.
	self selectIndex: anIndex
]

{ #category : #accessing }
BlCompositeSelection >> selections [
	<return: #BlSelectionTree>

	^ selections
]

{ #category : #'api - accessing' }
BlCompositeSelection >> to [
	"Return the maximum selected index which is the `to` index of the last sub-selection"
	<return: #Number>

	^ selections last selection to
]

"
I am a default implementation of communication interface between child manager and infinite element.
It is enough to use me in most cases.
"
Class {
	#name : #BlInfiniteDefaultChildrenController,
	#superclass : #BlInfiniteAbstractChildrenController,
	#instVars : [
		'infiniteElement',
		'childManager'
	],
	#category : #'Bloc-Infinite-Children'
}

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> addChild: anElement at: anIndex [
	infiniteElement telemetry
		timeSync: [ 'Add child {1} to infinite element at {2}' format: { anElement . anIndex } ]
		during: [ infiniteElement addChild: anElement at: anIndex. ].

	infiniteElement telemetry
		timeSync: [ 'Dispatch child {1} atatched to infinite element at {2}' format: { anElement . anIndex } ]
		during: [ infiniteElement dispatchChildAttached: anElement ]
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> attachChild: anElement at: anIndex [
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	(anElementHolder isTmpDetached not and: [ anElementHolder shouldIgnore not ])
		ifTrue: [ self error: 'Can not attach a child which is not previously detached ' ].
	
	anElementHolder clearTmpDetached.
	infiniteElement attachChild: anElement at: anIndex
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> childAt: anIndex [
	^ infiniteElement children at: anIndex
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> childIndexOf: aChildElement [
	^ infiniteElement childIndexOf: aChildElement
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> childrenCount [
	^ infiniteElement childrenCount
]

{ #category : #accessing }
BlInfiniteDefaultChildrenController >> childrenManager [
	^ childManager
]

{ #category : #accessing }
BlInfiniteDefaultChildrenController >> childrenManager: anObject [
	childManager := anObject.
	childManager controller: self
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> detachChildAt: anIndex [
	| anElement anElementHolder |
	anElement := infiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].
	
	anElementHolder := self elementHolderOf: anElement.
	
	(anElementHolder isTmpDetached and: [
		anElement shouldIgnore not ])
			ifTrue: [ self error: 'Can not detach already detached child!' ].
	
	anElementHolder flags addTmpDetached.
	infiniteElement detachChild: anElement
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> elementHolderOf: anElement [
	^ infiniteElement elementHolderOf: anElement
]

{ #category : #accessing }
BlInfiniteDefaultChildrenController >> infiniteElement [
	^ infiniteElement
]

{ #category : #accessing }
BlInfiniteDefaultChildrenController >> infiniteElement: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> removeAllChildren [
	
	1 to: self childrenCount do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		infiniteElement dispatchChildDetached: anElement ].
	
	infiniteElement removeAllChildren
]

{ #category : #'manager -> element' }
BlInfiniteDefaultChildrenController >> removeChildAt: anIndex [
	| anElement |
	anElement := infiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].

	infiniteElement dispatchChildDetached: anElement.
	infiniteElement removeChildAt: anIndex
]

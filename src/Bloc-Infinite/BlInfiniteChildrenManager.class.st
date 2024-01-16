"
I help to manage children (add / remove) and used as mediator between infinite element and data source.

"
Class {
	#name : #BlInfiniteChildrenManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Infinite-Core'
}

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> addChild: aChildElement at: anIndex in: anInfiniteElement [

	"Adds a child at an index.
	If an Index is less or equal 0 child will be appended to the end"

	| anOffset |
	anOffset := (anIndex <= 0
		             ifTrue: [ anInfiniteElement childrenCount + 1 ]
		             ifFalse: [ anIndex ]) max: 1.
	anInfiniteElement addChild: aChildElement at: anOffset.
	anInfiniteElement dispatchChildAttached: aChildElement.

]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> attachChild: aChildElement at: anIndex in: anInfiniteElement [

	"Attaches aChildElement to the infinite element"

	| anOffset anElementHolder |
	anOffset := (anIndex <= 0
		             ifTrue: [ anInfiniteElement childrenCount + 1 ]
		             ifFalse: [ anIndex ]) max: 1.

	anElementHolder := anInfiniteElement elementHolderOf: aChildElement.
	(anElementHolder isTmpDetached not and: [ anElementHolder shouldIgnore not ]) ifTrue: [ 
		self error: 'Can not attach a child which is not previously detached ' ].

	anElementHolder clearTmpDetached.
	anInfiniteElement attachChild: aChildElement at: anOffset
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> detachChildAt: anIndex in: anInfiniteElement [
	"Detaches a child element at anIndex from infinite element"
	| anElement anElementHolder |
	anElement := anInfiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].
	
	anElementHolder := anInfiniteElement elementHolderOf: anElement.
	
	(anElementHolder isTmpDetached and: [
		anElement shouldIgnore not ])
			ifTrue: [ self error: 'Can not detach already detached child!' ].
	
	anElementHolder flags addTmpDetached.
	anInfiniteElement detachChild: anElement
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeChild: aChildElement in: anInfiniteElement [
	"Remove aChildElement from infinite element
	and do not track it anymore (unhide and remove from bucket)"
	| index |

	index := anInfiniteElement childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ self ].
	
	self removeChildAt: index in: anInfiniteElement 
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeChildAt: anIndex in: anInfiniteElement [

	"Remove a child at anIndex from infinite element
	and do not track it anymore."

	| anElement |	
	anElement := anInfiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].

	anInfiniteElement dispatchChildDetached: anElement.
	anInfiniteElement removeChildAt: anIndex
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildAt: anIndex in: anInfiniteElement [
	"Return a child element by infinite element's offset.
	I will not offset this index"
	<return: #BlElement>

	^ anInfiniteElement childAt: anIndex
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildrenCountIn: anInfiniteElement [
	"Return the total number of children"
	<return: #Number>

	^ anInfiniteElement childrenCount
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildrenDo: aBlock in: anInfiniteElement [
	"Do not remove children in a Block!"
	| aChildCount |
	aChildCount := self unfilteredChildrenCountIn: anInfiniteElement.
	1 to: aChildCount do: [ :anIndex |
		aBlock value: (self unfilteredChildAt: anIndex in: anInfiniteElement) ]
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildrenReverseDo: aBlock in: anInfiniteElement [
	"Do not remove children in a Block!"
	| aChildCount |
	aChildCount := self unfilteredChildrenCountIn: anInfiniteElement.
	aChildCount to: 1 by: -1 do: [ :anIndex |
		aBlock value: (self unfilteredChildAt: anIndex in: anInfiniteElement) ]
]

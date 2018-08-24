"
I help to manage children (add / remove) and used as mediator between infinite element and data source.
"
Class {
	#name : #BlInfiniteChildrenManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'bucket',
		'hiddenChildren',
		'controller'
	],
	#category : 'Bloc-Infinite-Children'
}

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> addChild: aChildElement at: anIndex hidden: isHidden [
	"Adds a child at an index and makes it hidden if isHidden is true.
	If an Index is less or equal 0 child will be appended to the end"
	| anOffset |

	anOffset := (anIndex <= 0
		ifTrue: [ controller childrenCount + 1 ]
		ifFalse: [  (self computeOffset: anIndex) ]) max: 1.
	
	bucket insert: isHidden at: anOffset.
	
	isHidden ifTrue: [
		self hideChildInternal: aChildElement ].
	
	controller addChild: aChildElement at: anOffset
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> addChild: child hidden: isHidden [
	self addChild: child at: 0 hidden: isHidden
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> attachChild: aChildElement at: anIndex hidden: isHidden [
	"Attaches aChildElement to the infinite element"

	| anOffset |
	
	anOffset := (anIndex <= 0
		ifTrue: [ controller childrenCount + 1 ]
		ifFalse: [ self computeOffset: anIndex ]) max: 1.
	
	bucket insert: isHidden at: anOffset.

	isHidden
		ifTrue: [ self hideChildInternal: aChildElement ].
	
	controller attachChild: aChildElement at: anOffset
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> childAt: anIndex [
	"Returns the child at anIndex"
	<return: #BlElement>
	| anOffset |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].

	^ controller childAt: anOffset
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> childIndexOf: aChildElement [
	"Return the index of the child in regular perspective.
	Return 0 if child is not present in infinite element"
	<return: #Number>

	|index|
	
	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ 0 ].

	(bucket get: index)
		ifTrue: [ Error signal: 'can not get index of a hidden child' ].
		
	^ index - (bucket countOnesBefore: index)
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> childrenCount [
	"Return the number of not hidden children"
	<return: #Number>

	^ controller childrenCount - hiddenChildren size
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> childrenDo: aBlock [

	1 to: self childrenCount do: [ :anIndex |
		aBlock value: (self childAt: anIndex) ]
]

{ #category : #private }
BlInfiniteChildrenManager >> computeOffset: anIndex [
	"Compute an offset from item index within data source to child index within infinite element"
	| aLimit anOffset |

	anIndex <= 0
		ifTrue: [ ^ 0 ].
	
	aLimit := controller childrenCount.
	anOffset := anIndex.
	
	[ anOffset <= aLimit ] whileTrue: [ 
		| removedBefore diff |
		removedBefore := bucket countOnesBefore: anOffset.
		diff := anIndex - (anOffset - removedBefore).
		diff = 0
			ifTrue: [ 
				[ bucket get: anOffset ]
					whileTrue: [ anOffset := anOffset + 1 ].
				^ anOffset ]
		ifFalse: [ anOffset := anOffset + diff ] ].
	^ 0
]

{ #category : #accessing }
BlInfiniteChildrenManager >> controller [
	^ controller
]

{ #category : #accessing }
BlInfiniteChildrenManager >> controller: aChildController [
	controller := aChildController
]

{ #category : #initialization }
BlInfiniteChildrenManager >> defaultBucket [
	^ BlInfiniteBucket new
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> detachChildAt: anIndex [
	"Detaches a child element at anIndex from infinite element"
	| anOffset |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].
	
	bucket remove: anOffset.
	controller detachChildAt: anOffset
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> findHiddenNonRemovedChildAt: aPosition type: anItemType [
	"Return a disappearing child by position.
	Returns nil if child not found"
	<return: #BlElement or: nil>

	^ hiddenChildren
		detect: [ :child |
			| holder |
			holder := controller elementHolderOf: child.
			holder layoutPosition = aPosition
				and: [ holder isInvalid not
					and: [ holder isRemoved not
						and: [ anItemType = BlInfiniteItemType invalid
							or: [ holder itemType = anItemType ] ] ] ] ]
		ifNone: [ nil ]
]

{ #category : #testing }
BlInfiniteChildrenManager >> hasChildren [
	"Return true if there are any non-hidden children, false otherwise"
	<return: #Boolean>

	^ self childrenCount > 0
]

{ #category : #hidden }
BlInfiniteChildrenManager >> hide: aChildElement [
	"Marks a child element as hidden."
	| offset |

	offset := controller childIndexOf: aChildElement.
	offset <= 0
		ifTrue: [ Error signal: 'An element is not a direct child!' ].
	
	(bucket get: offset)
		ifTrue: [ Error signal: 'Trying to hide child twice' ].
		
	bucket set: offset.
	self hideChildInternal: aChildElement
]

{ #category : #hidden }
BlInfiniteChildrenManager >> hideChildInternal: aChildElement [
	"Marks a child element as hidden"
	hiddenChildren add: aChildElement.
	controller onEnteredHiddenState: aChildElement
]

{ #category : #initialization }
BlInfiniteChildrenManager >> initialize [
	super initialize.
	
	bucket := self defaultBucket.
	hiddenChildren := OrderedCollection new
]

{ #category : #testing }
BlInfiniteChildrenManager >> isHidden: aChildElement [
	"Returns whether a child is visible to InfiniteLayout or not"
	<return: #Boolean>

	^ hiddenChildren includes: aChildElement
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeAllChildrenUnfiltered [
	"Remove all children from the infinite element including the hidden ones"

	bucket reset.
	
	hiddenChildren copy reverseWithIndexDo: [ :child :index |
		controller onLeftHiddenState: child.
		hiddenChildren removeAt: index ].

	controller removeAllChildren
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeChild: aChildElement [
	"Remove aChildElement from infinite element
	and do not track it anymore (unhide and remove from bucket)"
	| index |

	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ self ].
	
	(bucket remove: index)
		ifTrue: [ self unhideChildInternal: aChildElement ].

	controller removeChildAt: index
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeChildAt: anIndex [
	"Remove a child at anIndex from infinite element
	and do not track it anymore."
	| anOffset anElement |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].
		
	anElement := controller childAt: anIndex.
	anElement
		ifNil: [ ^ self ].

	(bucket remove: anOffset)
		ifTrue: [ self unhideChildInternal: anElement ].

	controller removeChildAt: anIndex
]

{ #category : #'children add/remove' }
BlInfiniteChildrenManager >> removeChildIfHidden: aChildElement [
	"Remove a child element from infinite element if it is hidden.
	Return true of child was found, hidden and was succesfully removed,
	false otherwise"
	<return: #Boolean>

	| index |
		
	index := controller childIndexOf: aChildElement.
	(index <= 0)
		ifTrue: [
			(self unhideChildInternal: aChildElement)
				ifTrue:  [ Error signal: 'Child is not in the element' ] ].

	(bucket get: index) ifTrue: [ 
		bucket remove: index.
		(self unhideChildInternal: aChildElement)
			ifFalse: [ Error signal: 'Child is not on hidden list' ].
		controller removeChildAt: index.
		^ true ].

	^ false
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildAt: anIndex [
	"Return a child element by infinite element's offset.
	I will not offset this index"
	<return: #BlElement>

	^ controller childAt: anIndex
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildrenCount [
	"Return the total number of children"
	<return: #Number>

	^ controller childrenCount
]

{ #category : #'children accessing' }
BlInfiniteChildrenManager >> unfilteredChildrenDo: aBlock [
	"Do not remove children in a Block!"
	| aChildCount |
	aChildCount := self unfilteredChildrenCount.
	1 to: aChildCount do: [ :anIndex |
		aBlock value: (self unfilteredChildAt: anIndex) ]
]

{ #category : #hidden }
BlInfiniteChildrenManager >> unhideChildInternal: aChildElement [
	"Unmarks a child view as hidden.
	Return true if aChildElement was hidden before,
	false otherwise"
	<return: #Boolean>
	
	hiddenChildren
		remove: aChildElement
		ifAbsent: [ ^ false ].

	controller onLeftHiddenState: aChildElement.
	^ true
]

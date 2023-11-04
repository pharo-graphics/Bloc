Class {
	#name : #BlFocusability,
	#superclass : #Object,
	#classInstVars : [
		'after',
		'before',
		'block',
		'none',
		'ignore'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'accessing' }
BlFocusability class >> after [
	^ after ifNil: [ after := BlFocusabilityAfter new ]
]

{ #category : 'accessing' }
BlFocusability class >> before [
	^ before ifNil: [ before := BlFocusabilityBefore new ]
]

{ #category : 'accessing' }
BlFocusability class >> block [
	^ block ifNil: [ block := BlFocusabilityBlock new ]
]

{ #category : 'cleanup' }
BlFocusability class >> cleanUp [
	super cleanUp.
	
	before := nil.
	after := nil.
	block := nil.
	none := nil.
	ignore := nil
]

{ #category : 'accessing' }
BlFocusability class >> ignore [
	^ ignore ifNil: [ ignore := BlFocusabilityIgnore new ]
]

{ #category : 'accessing' }
BlFocusability class >> none [
	^ none ifNil: [ none := BlFocusabilityNone new ]
]

{ #category : 'comparing' }
BlFocusability >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'focus' }
BlFocusability >> focusables: anOrderedCollection along: aBlFocusSearchDirection of: anElement [
	"Add focusable elements that are descendants of a given element (possibly including anElement) to anOrderedCollection"

	self subclassResponsibility
]

{ #category : 'comparing' }
BlFocusability >> hash [
	^ self class hash
]

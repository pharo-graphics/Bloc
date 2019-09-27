"
I am a focus finder.

I am responsible for finding the next focusable element in a given direction from provided focused element
"
Class {
	#name : #BlFocusFinder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'bestCandidateBounds',
		'temporaryBounds',
		'focusedBounds'
	],
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #accessing }
BlFocusFinder >> bestCandidateBounds [
	^ bestCandidateBounds
]

{ #category : #initialization }
BlFocusFinder >> initialize [
	super initialize.
	
	bestCandidateBounds := BlBounds new.
	temporaryBounds := BlBounds new.
	focusedBounds := BlBounds new
]

{ #category : #'private - focus' }
BlFocusFinder >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds along: aBlFocusSearchDirection [
	| requestedFocusedBounds |
	
	requestedFocusedBounds := aFocusedBounds.
	
	aFocusedElement
		ifNotNil: [
			requestedFocusedBounds
				ifNil: [ requestedFocusedBounds := focusedBounds ].
			aFocusedElement focusedBounds: requestedFocusedBounds.
			aFocusRootElement localBoundsToMine: requestedFocusedBounds fromChild: aFocusedElement ]
		ifNil: [
			requestedFocusedBounds := aFocusedBounds.
			requestedFocusedBounds
				ifNil: [
					requestedFocusedBounds := focusedBounds.
					aBlFocusSearchDirection initFocusedBounds: requestedFocusedBounds root: aFocusRootElement ] ].
		
	^ aBlFocusSearchDirection
		nextFocus: aFocusedElement
		in: aCollectionOfElements
		within: aFocusRootElement
		from: requestedFocusedBounds
		finder: self
]

{ #category : #focus }
BlFocusFinder >> nextFocus: aFocusedElement within: aFocusRootElement along: aBlFocusSearchDirection [

	^ self
		nextFocus: aFocusedElement
		within: aFocusRootElement
		from: nil
		along: aBlFocusSearchDirection
]

{ #category : #'private - focus' }
BlFocusFinder >> nextFocus: aFocusedElement within: aFocusRootElement from: aFocusedBounds along: aBlFocusSearchDirection [
	| theFocusables nextFocus |
	
	nextFocus := nil.
	theFocusables := OrderedCollection new.
	
	aFocusRootElement focusables: theFocusables along: aBlFocusSearchDirection.
	theFocusables ifNotEmpty: [ 
		nextFocus := self
			nextFocus: aFocusedElement
			in: theFocusables
			within: aFocusRootElement
			from: aFocusedBounds
			along: aBlFocusSearchDirection ].
	
	
	^ nextFocus
]

{ #category : #focus }
BlFocusFinder >> nextFocusFrom: aFocusedBounds within: aFocusRootElement along: aBlFocusSearchDirection [
	
	focusedBounds bounds: aFocusedBounds.
	^ self
		nextFocus: nil
		within: aFocusRootElement
		from: focusedBounds
		along: aBlFocusSearchDirection
]

{ #category : #'private - accessing' }
BlFocusFinder >> nextFocusable: anElement in: aCollection [
	"Return a next focusable element after a given element within provided collection.
	If anElement is nil I return the first element from a collection or nil if it is empty"
	<return: #BlElement or: nil>

	^ anElement
		ifNotNil: [ | position |
			position := aCollection lastIndexOf: anElement.
			(position > 0 and: [ position + 1 <= aCollection size ])
				ifTrue: [ aCollection at: position + 1 ]
				ifFalse: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection first ] ] ]
		ifNil: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection first ] ]
]

{ #category : #'private - accessing' }
BlFocusFinder >> previousFocusable: anElement in: aCollection [
	"Return a previous focusable element before a given element within provided collection.
	If anElement is nil I return the last element from a collection or nil if it is empty"
	<return: #BlElement or: nil>

	^ anElement
		ifNotNil: [ | position |
			position := aCollection lastIndexOf: anElement.
			position > 1
				ifTrue: [ aCollection at: position - 1 ]
				ifFalse: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection last ] ] ]
		ifNil: [ aCollection
			ifEmpty: [ nil ]
			ifNotEmpty: [ aCollection last ] ]
]

{ #category : #accessing }
BlFocusFinder >> temporaryBounds [
	^ temporaryBounds
]

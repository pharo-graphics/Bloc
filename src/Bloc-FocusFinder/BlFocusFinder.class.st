"
I am a focus finder.

I am responsible for finding the next focusable element in a given direction from provided focused element

"
Class {
	#name : 'BlFocusFinder',
	#superclass : 'Object',
	#instVars : [
		'direction',
		'rootElement',
		'bestCandidateBounds',
		'temporaryBounds',
		'focusedBounds',
		'reference'
	],
	#category : 'Bloc-FocusFinder-Core',
	#package : 'Bloc-FocusFinder',
	#tag : 'Core'
}

{ #category : 'accessing' }
BlFocusFinder >> bestCandidateBounds [

	^ bestCandidateBounds
]

{ #category : 'accessing' }
BlFocusFinder >> direction [

	^ direction
]

{ #category : 'accessing' }
BlFocusFinder >> direction: aBlFocusSearchDirection [

	direction := aBlFocusSearchDirection
]

{ #category : 'api - configuration' }
BlFocusFinder >> down [

	self direction: BlFocusSearchDirectionDown new
]

{ #category : 'initialization' }
BlFocusFinder >> initialize [

	super initialize.
	
	bestCandidateBounds := BlBounds new.
	temporaryBounds := BlBounds new.
	focusedBounds := BlBounds new.

	direction := BlFocusSearchDirectionDown new.
	rootElement := BlElement new.
	reference := BlFocusFinderReferenceArea new bounds: (0@0 extent: 0@0)
]

{ #category : 'api - configuration' }
BlFocusFinder >> left [

	self direction: BlFocusSearchDirectionLeft new
]

{ #category : 'api - finder' }
BlFocusFinder >> nextFocusDo: aBlock [
	"Evaluate aBlock with the next element that should receive focus"
	
	self
		nextFocusDo: aBlock
		ifNone: [  ]
]

{ #category : 'api - finder' }
BlFocusFinder >> nextFocusDo: aBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with the next element that should receive focus"

	| aReferenceBounds aReferenceElement theFocusCandidates |
	aReferenceBounds := reference focusBoundsIn: rootElement.
	aReferenceElement := reference focusElementIn: rootElement.

	theFocusCandidates := BlFocusFinderCandidates new.
	rootElement focusables: theFocusCandidates along: direction.
	
	^ (direction
		nextFocus: aReferenceElement
		in: theFocusCandidates
		within: rootElement
		from: aReferenceBounds
		finder: self)
			ifNotNil: aBlock
			ifNil: anExceptionBlock
]

{ #category : 'accessing' }
BlFocusFinder >> reference [

	^ reference
]

{ #category : 'accessing' }
BlFocusFinder >> reference: anObject [

	reference := anObject
]

{ #category : 'api - configuration' }
BlFocusFinder >> referenceArea: aRectangle [

	self reference: (BlFocusFinderReferenceArea new bounds: aRectangle)
]

{ #category : 'api - configuration' }
BlFocusFinder >> referenceElement: aBlElement [

	self reference:
		(BlFocusFinderReferenceElement new
			element: aBlElement;
			yourself)
]

{ #category : 'api - configuration' }
BlFocusFinder >> right [

	self direction: BlFocusSearchDirectionRight new
]

{ #category : 'accessing' }
BlFocusFinder >> root [

	^ rootElement
]

{ #category : 'accessing' }
BlFocusFinder >> root: aBlElement [

	rootElement := aBlElement
]

{ #category : 'accessing' }
BlFocusFinder >> temporaryBounds [

	^ temporaryBounds
]

{ #category : 'api - configuration' }
BlFocusFinder >> up [

	self direction: BlFocusSearchDirectionUp new
]

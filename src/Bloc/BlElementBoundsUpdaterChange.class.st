Class {
	#name : #BlElementBoundsUpdaterChange,
	#superclass : #Object,
	#instVars : [
		'element',
		'previousPosition',
		'newPosition',
		'previousExtent',
		'newExtent',
		'compositionDepth'
	],
	#category : 'Bloc-Basic-Bounds'
}

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> changeExtentFrom: aPreviousExtent to: aNewExtent [
	previousExtent ifNil: [ previousExtent := aPreviousExtent ].
	newExtent := aNewExtent
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> changePositionFrom: aPreviousPosition to: aNewPosition [
	previousPosition ifNil: [ previousPosition := aPreviousPosition ].
	newPosition := aNewPosition
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> commitLocalChanges [
	self commitLocalExtentChange.
	self commitLocalPositionChange
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> commitLocalExtentChange [
	| aPreviousExtent |

	newExtent
		ifNil: [ ^ self ].
		
	aPreviousExtent := previousExtent ifNil: [ 0@0 ].

	(newExtent closeTo: aPreviousExtent epsilon: BlElement epsilon)
		ifTrue: [ ^ self ].
	
	self element onExtentChanged
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> commitLocalPositionChange [
	| aPreviousPosition |
	newPosition
		ifNil: [ ^ self ].
		
	aPreviousPosition := previousPosition ifNil: [ 0@0 ].
	
	(newPosition closeTo: aPreviousPosition epsilon: BlElement epsilon)
		ifTrue: [ ^ self ].
	
	self element onPositionChangedFrom: aPreviousPosition to: newPosition
]

{ #category : #'api - compositing' }
BlElementBoundsUpdaterChange >> compositionDepth [
	
	^ compositionDepth ifNil: [ compositionDepth := element compositionDepth ]
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> element [
	^ element
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> element: anObject [
	element := anObject
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> isExtentChanged [
	| aPreviousExtent |

	newExtent
		ifNil: [ ^ false ].
		
	aPreviousExtent := previousExtent ifNil: [ 0@0 ].
	^ (newExtent closeTo: aPreviousExtent epsilon: BlElement epsilon) not
]

{ #category : #'api - changes' }
BlElementBoundsUpdaterChange >> isPositionChanged [
	| aPreviousPosition |

	newPosition
		ifNil: [ ^ false ].
		
	aPreviousPosition := previousPosition ifNil: [ 0@0 ].
	^ (newPosition closeTo: aPreviousPosition epsilon: BlElement epsilon) not
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> newExtent [
	^ newExtent
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> newExtent: anObject [
	newExtent := anObject
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> newPosition [
	^ newPosition
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> newPosition: anObject [
	newPosition := anObject
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> previousExtent [
	^ previousExtent
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> previousExtent: anObject [
	previousExtent := anObject
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> previousPosition [
	^ previousPosition
]

{ #category : #accessing }
BlElementBoundsUpdaterChange >> previousPosition: anObject [
	previousPosition := anObject
]

"
Relative anchor takes an arbitrary element as a reference an compute its position based on properties of that element.
"
Class {
	#name : #BlAnchorRelativeToElement,
	#superclass : #BlGeometryAnchor,
	#instVars : [
		'moveDispatched',
		'referenceElement'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlAnchorRelativeToElement class >> element: anElement [
	<return: #BlAnchorRelativeToElement>

	^ self new
		referenceElement: anElement;
		yourself
]

{ #category : #accessing }
BlAnchorRelativeToElement class >> label [
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlAnchorRelativeToElement class >> referenceElement: anElement relatedTo: anotherElement [
	"Some types of achors should take other element into account"
	<return: #BlAnchorRelativeToElement>

	"By default most we only care about a single reference element"
	^ self element: anElement
]

{ #category : #'event dispatching' }
BlAnchorRelativeToElement >> dispatchMoveEvent [
	"I dispatch anchor moved event"

	moveDispatched
		ifTrue: [ ^ self ].
	moveDispatched := true.
	
	[ self dispatchEvent: (BlGeometryAnchorMoved new anchor: self) ]
		ensure: [ moveDispatched := false ]
]

{ #category : #geometry }
BlAnchorRelativeToElement >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlAnchorRelativeToElement >> globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor [
	<return: #Collection of: #Point>
	| aFromPoint aToPoint theBoundsInSpace aFromRay aToRay aDirectionVector aLength |

	aFromPoint := self globalPositionWithin: aGeometryElement.
	aToPoint := anAnotherAnchor globalPositionWithin: aGeometryElement.

	theBoundsInSpace := self referenceElement bounds inSpace bounds.

	aFromRay := theBoundsInSpace outsideNormalCloseTo: aFromPoint.
	aToRay := theBoundsInSpace outsideNormalCloseTo: aToPoint.

	(aFromRay vector isParallel: aToRay vector)
		ifTrue: [
			aFromRay vector rotateBy: 45 degreesToRadians.
			aToRay vector rotateBy: 45 negated degreesToRadians. ].

	aDirectionVector := (aToPoint - aFromPoint) asBlocVector * 2.
	aLength := aDirectionVector length max: 150.

	^ {
		aFromRay point + (aFromRay vector * aLength).
		aToRay point + (aToRay vector * aLength)
	}
]

{ #category : #initialization }
BlAnchorRelativeToElement >> initialize [
	super initialize.

	moveDispatched := false
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfTo: anAnotherAnchor [
	<return: #Boolean>
	
	^ anAnotherAnchor isSelfToRelative: self
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfToAbsolute: anAnotherAnchor [
	<return: #Boolean>
	
	^ false
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfToRelative: anAnotherAnchor [
	<return: #Boolean>

	^ self referenceElement = anAnotherAnchor referenceElement
]

{ #category : #accessing }
BlAnchorRelativeToElement >> referenceElement [
	<return: #BlElement>

	^ referenceElement
]

{ #category : #accessing }
BlAnchorRelativeToElement >> referenceElement: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].

	self
		assert: [ referenceElement isNil ]
		description: [ 'Reference element can not be changed once set' ].

	referenceElement := anElement.
	referenceElement
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ].
	referenceElement
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ]
]

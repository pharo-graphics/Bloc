"
I represent an anchor of a geometry element, which is driven by anchor positions.

See my subclasses for a different anchor strategies.
"
Class {
	#name : #BlGeometryAnchor,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'eventDispatcher',
		'computedPosition'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #'event handling' }
BlGeometryAnchor >> anchorListenerClass [
	^ BlGeometryAnchorListener
]

{ #category : #'event handling' }
BlGeometryAnchor >> attachTo: aGeometryElement [
	self addEventHandler: (self anchorListenerClass for: aGeometryElement)
]

{ #category : #geometry }
BlGeometryAnchor >> computePositionWithin: aGeometryElement [
	"Return anchor position within a given geometry element in its parent bounds"
	<return: #Point>

	^ aGeometryElement globalPointToParent: (self globalPositionWithin: aGeometryElement)
]

{ #category : #accessing }
BlGeometryAnchor >> computedPosition [
	<return: #Point>

	^ computedPosition
]

{ #category : #accessing }
BlGeometryAnchor >> computedPosition: aPoint [
	computedPosition := aPoint
]

{ #category : #initialization }
BlGeometryAnchor >> defaultEventDispatcher [
	"Return class of event dispatcher.
	Instantiation happens in initialize"
	^ BlDirectEventDispatcher
]

{ #category : #'event handling' }
BlGeometryAnchor >> detachFrom: aGeometryElement [
	self removeEventHandlersSuchThat: [ :anEventHandler |
		(anEventHandler class = self anchorListenerClass)
			and: [ anEventHandler geometryElement == aGeometryElement ] ]
]

{ #category : #'event management accessing' }
BlGeometryAnchor >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #geometry }
BlGeometryAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlGeometryAnchor >> globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor [
	<return: #Collection of: #Point>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlGeometryAnchor >> initialize [
	super initialize.
	
	eventDispatcher := self defaultEventDispatcher on: self
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfTo: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfToAbsolute: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfToRelative: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlGeometryAnchor >> positionWithin: aGeometryElement [
	"Compute and return a position of this anchor in parent coordinates of the *anchor* element
	taking into account a given geometry element"
	<return: #Point>

	^ self computedPosition
		ifNil: [ computedPosition := self computePositionWithin: aGeometryElement ]
]

{ #category : #geometry }
BlGeometryAnchor >> selfPositionsWithin: aGeometryElement and: anAnotherAnchor [
	<return: #Collection of: #Point>
	
	^ (self globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor)
			collect: [ :aPoint | aGeometryElement globalPointToParent: aPoint ]
]

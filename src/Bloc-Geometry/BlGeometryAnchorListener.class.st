"
I am an event listener that listens Anchor Moved event send by Anchor
"
Class {
	#name : #BlGeometryAnchorListener,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'geometryElement'
	],
	#category : #'Bloc-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlGeometryAnchorListener class >> for: aGeometryElement [
	<return: #BlGeometryAnchorListener>

	^ self new geometryElement: aGeometryElement
]

{ #category : #accessing }
BlGeometryAnchorListener >> eventClass [
	^ BlGeometryAnchorMoved
]

{ #category : #'api - accessing' }
BlGeometryAnchorListener >> eventsToHandle [
	^ { self eventClass }
]

{ #category : #accessing }
BlGeometryAnchorListener >> geometryElement [
	<return: #BlElement>

	^ geometryElement
]

{ #category : #accessing }
BlGeometryAnchorListener >> geometryElement: aBlElement [
	geometryElement := aBlElement
]

{ #category : #events }
BlGeometryAnchorListener >> handleEvent: anEvent [
	self onAnchorMoved: anEvent anchor
]

{ #category : #anchors }
BlGeometryAnchorListener >> onAnchorMoved [
	self geometryElement onAnchorMoved
]

{ #category : #anchors }
BlGeometryAnchorListener >> onAnchorMoved: aBlGeometryAnchor [
	| aPosition |
	
	aPosition := (aBlGeometryAnchor computePositionWithin: self geometryElement).
	(aPosition = aBlGeometryAnchor computedPosition)
		ifTrue: [ ^ self ]
		ifFalse: [ aBlGeometryAnchor computedPosition: aPosition ].

	self onAnchorMoved
]

{ #category : #installation }
BlGeometryAnchorListener >> onInstalledIn: anObject [
	self onAnchorMoved
]

{ #category : #events }
BlGeometryAnchorListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]

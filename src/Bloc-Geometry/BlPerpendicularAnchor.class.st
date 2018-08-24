"
I am a virtual anchor that lays on a perpendicular to a line between two reference anchors.

The curvature - distance from the line connecting reference anchors is explicitely user-defined
"
Class {
	#name : #BlPerpendicularAnchor,
	#superclass : #BlAnchorRelativeToAnchor,
	#instVars : [
		'curvature'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlPerpendicularAnchor class >> curvature: aNumber [
	^ self new curvature: aNumber
]

{ #category : #accessing }
BlPerpendicularAnchor >> curvature [
	^ curvature
]

{ #category : #accessing }
BlPerpendicularAnchor >> curvature: anObject [
	curvature := anObject
]

{ #category : #geometry }
BlPerpendicularAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aFromPosition aToPosition aDirection aPerpendicular aMiddle aCurvatureOrigin aCurvatureCorner |

	self
		assert: [ self referenceAnchors size = 2 ]
		description: [ 'Perpendicular anchor requires two anchors to work properly' ].

	aFromPosition := (self referenceAnchors first globalPositionWithin: aGeometryElement) asBlocVector.
	aToPosition := (self referenceAnchors second globalPositionWithin: aGeometryElement) asBlocVector.

	aCurvatureOrigin := (aGeometryElement localPointToGlobal: 0@0) asBlocVector.
	aCurvatureCorner := (aGeometryElement localPointToGlobal: 0 @ self curvature) asBlocVector.
	
	aDirection := aToPosition - aFromPosition.
	aPerpendicular := aDirection normal negated * (aCurvatureCorner - aCurvatureOrigin) length.
	aMiddle := aFromPosition + (aDirection / 2.0).

	^ (aMiddle + aPerpendicular) asPoint
]

{ #category : #initialization }
BlPerpendicularAnchor >> initialize [
	super initialize.
	
	curvature := 30
]

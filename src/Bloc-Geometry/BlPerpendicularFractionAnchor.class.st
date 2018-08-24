"
I am a virtual anchor that lays on a perpendicular to a line between two reference anchors.

The curvature - distance from the line connecting reference anchors is defined as a fraction (curvatureFraction) of a length between anchors.
"
Class {
	#name : #BlPerpendicularFractionAnchor,
	#superclass : #BlAnchorRelativeToAnchor,
	#instVars : [
		'curvatureFraction'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlPerpendicularFractionAnchor class >> fraction: aNumber [
	^ self new curvatureFraction: aNumber
]

{ #category : #accessing }
BlPerpendicularFractionAnchor >> curvatureFraction [
	"How long should perpendicular vector be compared to the distance between reference anchors.
	If fraction is set to 1.0 the length is equal to the distance between anchors"
	<return: #Number>

	^ curvatureFraction
]

{ #category : #accessing }
BlPerpendicularFractionAnchor >> curvatureFraction: aNumber [
	curvatureFraction := aNumber
]

{ #category : #geometry }
BlPerpendicularFractionAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aFromPosition aToPosition aDirection aPerpendicular aMiddle |

	self
		assert: [ self referenceAnchors size = 2 ]
		description: [ 'Perpendicular anchor requires two anchors to work properly' ].

	aFromPosition := (self referenceAnchors first globalPositionWithin: aGeometryElement) asBlocVector.
	aToPosition := (self referenceAnchors second globalPositionWithin: aGeometryElement) asBlocVector.
	
	aDirection := aToPosition - aFromPosition.
	aPerpendicular := aDirection normal negated * aDirection length * self curvatureFraction.
	aMiddle := aFromPosition + (aDirection / 2.0).

	^ (aMiddle + aPerpendicular) asPoint
]

{ #category : #initialization }
BlPerpendicularFractionAnchor >> initialize [
	super initialize.
	
	curvatureFraction := 1.0
]

"
I allow users to provide a fixed normalized location (top left is 0@0 and bottom right is 1@1, negative and larger values are allowed) that should be used as transformation origin

"
Class {
	#name : #BlAffineTransformationNormalizedPositionOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlAffineTransformationNormalizedPositionOrigin class >> position: aPoint [

	^ self new
		  position: aPoint;
		  yourself
]

{ #category : #comparing }
BlAffineTransformationNormalizedPositionOrigin >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self position = anObject position
]

{ #category : #math }
BlAffineTransformationNormalizedPositionOrigin >> originIn: anElement [
	"Return a point describing an origin of a transformation within a given element.
	Origin can be either a 2D or 3D points and should be given in local coordinates of the element"

	^ position * anElement extent
]

{ #category : #accessing }
BlAffineTransformationNormalizedPositionOrigin >> position [

	^ position
]

{ #category : #accessing }
BlAffineTransformationNormalizedPositionOrigin >> position: aPoint [

	position := aPoint
]

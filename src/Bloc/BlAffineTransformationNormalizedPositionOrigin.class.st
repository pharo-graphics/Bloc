"
I allow users to provide a fixed normalized location (top left is 0@0 and bottom right is 1@1, negative and larger values are allowed) that should be used as transformation origin

"
Class {
	#name : 'BlAffineTransformationNormalizedPositionOrigin',
	#superclass : 'BlAffineTransformationOrigin',
	#instVars : [
		'position'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'instance creation' }
BlAffineTransformationNormalizedPositionOrigin class >> position: aPoint [
	^ self new position: aPoint
]

{ #category : 'math' }
BlAffineTransformationNormalizedPositionOrigin >> originIn: anElement [
	"Return a point describing an origin of a transformation within a given element.
	Origin can be either a 2D or 3D points and should be given in local coordinates of the element"
	<return: #Point or: #BlPoint3D>

	^ position * anElement extent
]

{ #category : 'accessing' }
BlAffineTransformationNormalizedPositionOrigin >> position [
	<return: #Point or: #BlPoint3D>

	^ position
]

{ #category : 'accessing' }
BlAffineTransformationNormalizedPositionOrigin >> position: aPoint [
	position := aPoint
]

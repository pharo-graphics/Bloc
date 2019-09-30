"
I allow users to provide a fixed location that should be used as transformation origin
"
Class {
	#name : #BlAffineTransformationPositionOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlAffineTransformationPositionOrigin class >> position: aPoint [
	^ self new position: aPoint
]

{ #category : #math }
BlAffineTransformationPositionOrigin >> originIn: anElement [
	"@see Method comment BlAffineTransformationOrigin>>#originIn:"
	<return: #Point or: #BlPoint3D>

	^ self position
]

{ #category : #accessing }
BlAffineTransformationPositionOrigin >> position [
	<return: #Point or: #BlPoint3D>

	^ position
]

{ #category : #accessing }
BlAffineTransformationPositionOrigin >> position: aPoint [
	position := aPoint
]

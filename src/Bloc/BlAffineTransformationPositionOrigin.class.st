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

	^ self new
		  position: aPoint;
		  yourself
]

{ #category : #comparing }
BlAffineTransformationPositionOrigin >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self position = anObject position
]

{ #category : #math }
BlAffineTransformationPositionOrigin >> originIn: anElement [

	^ position
]

{ #category : #accessing }
BlAffineTransformationPositionOrigin >> position [

	^ position
]

{ #category : #accessing }
BlAffineTransformationPositionOrigin >> position: aPoint [

	position := aPoint
]

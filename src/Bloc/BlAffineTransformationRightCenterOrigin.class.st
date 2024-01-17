"
I am a relative transformation origin which is attached to the right center of an element.

"
Class {
	#name : #BlAffineTransformationRightCenterOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #math }
BlAffineTransformationRightCenterOrigin >> originIn: anElement [

	^ anElement width @ (anElement height / 2.0)
]

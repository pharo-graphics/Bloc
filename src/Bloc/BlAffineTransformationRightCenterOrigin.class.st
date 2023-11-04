"
I am a relative transformation origin which is attached to the right center of an element.

"
Class {
	#name : 'BlAffineTransformationRightCenterOrigin',
	#superclass : 'BlAffineTransformationOrigin',
	#package : 'Bloc',
	#tag : 'Basic-Transformations'
}

{ #category : 'math' }
BlAffineTransformationRightCenterOrigin >> originIn: anElement [

	^ anElement width @ (anElement height / 2.0)
]

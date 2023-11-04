"
I am a relative transformation origin which is attached to the left center of an element.

"
Class {
	#name : 'BlAffineTransformationLeftCenterOrigin',
	#superclass : 'BlAffineTransformationOrigin',
	#package : 'Bloc',
	#tag : 'Basic-Transformations'
}

{ #category : 'math' }
BlAffineTransformationLeftCenterOrigin >> originIn: anElement [

	^ 0 @ (anElement height / 2.0)
]

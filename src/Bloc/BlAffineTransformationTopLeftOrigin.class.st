"
I am a relative transformation origin which is attached to the top left of an element.

"
Class {
	#name : #BlAffineTransformationTopLeftOrigin,
	#superclass : #BlAffineTransformationOrigin,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #math }
BlAffineTransformationTopLeftOrigin >> originIn: anElement [
	"@see Method comment BlAffineTransformationOrigin>>#originIn:"
	<return: #Point or: #BlPoint3D>

	^ 0 @ 0
]

"
I represent an origin of the affine transformation.
I can be very useful when users want to rotate / scale or shear an element about its center or one of the corners

"
Class {
	#name : #BlAffineTransformationOrigin,
	#superclass : #Object,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #comparing }
BlAffineTransformationOrigin >> = anObject [

	^ self class = anObject class
]

{ #category : #math }
BlAffineTransformationOrigin >> originIn: anElement [
	"Return a point describing an origin of a transformation within a given element.
	Origin can be either a 2D or 3D point (`Point` or `BlPoint3D`) and should be given in local coordinates of the element"

	^ self subclassResponsibility
]

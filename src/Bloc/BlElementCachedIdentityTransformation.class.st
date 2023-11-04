"
I cache a `BlElementIdentityTransformation` and provide a singleton instance.
"
Class {
	#name : #BlElementCachedIdentityTransformation,
	#superclass : #BlElementCachedTransformation,
	#instVars : [
		'identityMatrix'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'cleanup' }
BlElementCachedIdentityTransformation class >> cleanUp [

	uniqueInstance := nil
]

{ #category : 'accessing' }
BlElementCachedIdentityTransformation class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'api - converting' }
BlElementCachedIdentityTransformation >> asElementTransformation [

	^ BlElementIdentityTransformation uniqueInstance
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> boundingRectangle: aRectangle [
	"The actual transformation matrix may depend on the element bounds due to potential non-zero transformation origin.
	This message allows cached transformation to recompute the transformation matrix when bounds change.
	It doesn't have any effect on identity transformation."

]

{ #category : 'initialization' }
BlElementCachedIdentityTransformation >> initialize [

	super initialize.

	identityMatrix := BlMatrix2D new.
	identityMatrix beReadOnlyObject
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> inverseTransformBounds: aBlBounds [
	"Transform the given bounds according to inverse of my cached transformation.
	(Global to local transformation.)"
	
	^ aBlBounds
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> inverseTransformPoint: aPoint [
	"Answer the `Point` that results from applying the inversed transformation on a given point."
	
	^ aPoint
]

{ #category : 'api - testing' }
BlElementCachedIdentityTransformation >> isIdentity [

	^ true
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> matrix [
	
	^ identityMatrix
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> transformBounds: aBlBounds [
	"Transform the given bounds according to my cached transformation.
	(Local to global transformation.)"
	
	^ aBlBounds
]

{ #category : 'api - transformation' }
BlElementCachedIdentityTransformation >> transformPoint: aPoint [
	"Transform a given 2D point according to my cached transformation.
	(Local to global transformation.)"
	
	^ aPoint
]

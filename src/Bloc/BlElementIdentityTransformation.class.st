"
# Element's identity transformation
Stateless transformation object that represents an identity transformation of an element.
The best used as a unique instance

"
Class {
	#name : 'BlElementIdentityTransformation',
	#superclass : 'BlElementTransformation',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'accessing' }
BlElementIdentityTransformation class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlElementIdentityTransformation class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'converting' }
BlElementIdentityTransformation >> asCachedTransformation [
	^ BlElementCachedIdentityTransformation uniqueInstance
]

{ #category : 'computation' }
BlElementIdentityTransformation >> computeMatrix: aBlMatrix in: aRectangle [
	^ aBlMatrix
]

{ #category : 'testing' }
BlElementIdentityTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : 'testing' }
BlElementIdentityTransformation >> is3D [
	<return: #Boolean>
	
	^ false
]

{ #category : 'testing' }
BlElementIdentityTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : 'testing' }
BlElementIdentityTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
	^ true
]

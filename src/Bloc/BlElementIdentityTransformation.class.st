"
I'm an element's identity transformation: a stateless transformation object that represents an identity transformation of an element.

I provide a singleton instance.
"
Class {
	#name : #BlElementIdentityTransformation,
	#superclass : #BlElementTransformation,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #accessing }
BlElementIdentityTransformation class >> cleanUp [

	uniqueInstance := nil
]

{ #category : #accessing }
BlElementIdentityTransformation class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #enumerating }
BlElementIdentityTransformation >> affineTransformationsDo: aBlockClosure [ 
	"Do nothing"
]

{ #category : #converting }
BlElementIdentityTransformation >> asCachedTransformationIn: aRectangle [
	"The Rectangle is ignored by identity"

	^ BlElementCachedIdentityTransformation uniqueInstance
]

{ #category : #computation }
BlElementIdentityTransformation >> computeMatrix: aBlMatrix in: aRectangle [

	^ aBlMatrix
]

{ #category : #testing }
BlElementIdentityTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	
	^ true
]

{ #category : #testing }
BlElementIdentityTransformation >> is3D [
	
	^ false
]

{ #category : #testing }
BlElementIdentityTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	
	^ true
]

{ #category : #testing }
BlElementIdentityTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	
	^ true
]

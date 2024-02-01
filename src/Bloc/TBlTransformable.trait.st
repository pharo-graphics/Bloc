"
I define an interface that transformable objects should implement in order to support affine transformations
"
Trait {
	#name : #TBlTransformable,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #transformations }
TBlTransformable >> transform [
	
	^ BlTransformationBuilder on: self
]

{ #category : #transformations }
TBlTransformable >> transformDo: aBlock [

	| aTransformationBuilder |
	aTransformationBuilder := self transform.
	aBlock value: aTransformationBuilder.
	aTransformationBuilder apply
]

{ #category : #transformations }
TBlTransformable >> transformation [
	"Return a `BlElementTransformation` that represents a description of my transformation.
	It can either be a local transformation being a composition of affine transformations or
	and absolute transformation directly defined with matrix"

	^ self explicitRequirement
]

{ #category : #transformations }
TBlTransformable >> transformation: aBlElementTransformation [

	self explicitRequirement
]

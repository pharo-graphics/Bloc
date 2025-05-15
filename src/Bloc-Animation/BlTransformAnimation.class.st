"
I am special type of animation designed to operate on element's transformation.

Transform animation can be absolute or relative.
(consistent with absolute/relative vector path builder)
 - #relative builds on existing element transformation
 - #absolute defines new element independent transformation

`BlTransformAnimation` uses `BlElementAbsoluteTransformation` to manage the transformation matrix, even if each transformation uses `BlElementLocalTransformation` for its defintion.  This transformation works by updating its transformation matrix from the identity matrix to target matrix. This is done through interpolation computed at each animation step (fromMatrix interpolate: aNumber to: toMatrix). 

This transformation doesn't use an origin point. Instead, It'll apply a translation, so that your shape still look like it's in the element bound. This translation is added to your transformation definition (boundingRectangle:)
"
Class {
	#name : #BlTransformAnimation,
	#superclass : #BlAnimation,
	#traits : 'TBlTransformable',
	#classTraits : 'TBlTransformable classTrait',
	#instVars : [
		'isAbsolute',
		'elementTransformation',
		'fromDecomposition',
		'toDecomposition'
	],
	#category : #'Bloc-Animation-Animation'
}

{ #category : #'instance creation' }
BlTransformAnimation class >> rotate: anAngleInDegrees [
	"Create a rotation transformation by a given angle in degrees"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder rotateBy: anAngleInDegrees ];
		yourself
]

{ #category : #'instance creation' }
BlTransformAnimation class >> scale: aVector [
	"Create a scaling transformation by a given factor defined by a vector"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder scaleBy: aVector ];
		yourself
]

{ #category : #'instance creation' }
BlTransformAnimation class >> translate: aVector [
	"Create a translation transformation by a given vector"
	<return: #BlTransformAnimation>
	
	^ self new
		transformDo: [ :aBuilder | aBuilder translateBy: aVector ];
		yourself
]

{ #category : #builder }
BlTransformAnimation >> absolute [

	isAbsolute := true
]

{ #category : #pulse }
BlTransformAnimation >> applyValue: anElementTransformation [

	self target transformation: anElementTransformation
]

{ #category : #'private - running' }
BlTransformAnimation >> initStart [

	super initStart.

	isAbsolute ifFalse: [
		elementTransformation :=
			BlElementCompositeTransformation new
				add: self target transformation asElementTransformation;
				add: elementTransformation asElementTransformation;
				yourself ].

	"matrix depends on computed layout bounds, we should manually trigger layout recomputation"
	(self target space isNotNil and: [
		self target space isLayoutRequested ]) ifTrue: [
		self target space doLayout ].

	elementTransformation :=
		elementTransformation asCachedTransformationIn: 
			self target boundsInLocal asRectangle.

	"Calculate matrix only on start of first loop"
	fromDecomposition ifNil: [
		fromDecomposition := self target transformation matrix decomposition.
		toDecomposition := elementTransformation matrix decomposition ]
]

{ #category : #initialization }
BlTransformAnimation >> initialize [

	super initialize.

	isAbsolute := false.
	elementTransformation := BlElementLocalTransformation new
]

{ #category : #builder }
BlTransformAnimation >> relative [

	isAbsolute := false
]

{ #category : #transformations }
BlTransformAnimation >> transformation [

	^ elementTransformation
]

{ #category : #transformations }
BlTransformAnimation >> transformation: aBlElementTransformation [

	elementTransformation := aBlElementTransformation
]

{ #category : #pulse }
BlTransformAnimation >> valueForStep: aNumber [

	^ BlElementAbsoluteTransformation matrix:
		  (fromDecomposition interpolate: aNumber to: toDecomposition) composition
]

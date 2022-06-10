"
I a transformation builder and allow users to create and modify complex transformation chains.

Example of a builder that appends new transformations to existing ones:

element transform
	inherit;
	origin: (BlAffineTransformationPositionOrigin position: 0@0);
	translateBy: (BlVector x: 100 y: 100 z: 0);
	scaleBy: (BlVector x: 2 y: 0.5 z: 1);
	apply

"
Class {
	#name : #BlTransformationBuilder,
	#superclass : #Object,
	#instVars : [
		'transformation',
		'origin',
		'target'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlTransformationBuilder class >> on: anObject [
	<return: #BlTransformationBuilder>

	^ self new target: anObject
]

{ #category : #transformations }
BlTransformationBuilder >> apply [
	"Replace element's transformation chain with our new one that we just have built"
	| anElementTransformation |

	anElementTransformation := BlElementLocalTransformation with: transformation.
	target transformation: anElementTransformation
]

{ #category : #origin }
BlTransformationBuilder >> centerOrigin [
	self origin: BlAffineTransformationCenterOrigin new
]

{ #category : #accessing }
BlTransformationBuilder >> element [
	self 
		deprecated: 'Use target instead'
		on: 	'5 November 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
	^ self target
]

{ #category : #accessing }
BlTransformationBuilder >> element: anObject [ 
	self 
		deprecated: 'Use target: instead'
		on: 	'5 November 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
	^ self target: anObject
]

{ #category : #transformations }
BlTransformationBuilder >> flipX [
	transformation addTransformation: (BlReflectionTransformation vertical origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> flipY [
	transformation addTransformation: (BlReflectionTransformation horizontal origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> inherit [
	"Append existing element's transformations to the new transformation list"
	
	target transformation asElementTransformation transformation
		do: [ :aTransformation | transformation addTransformation: aTransformation ]
]

{ #category : #initialization }
BlTransformationBuilder >> initialize [
	super initialize.
	
	transformation := BlAffineCompositeTransformation new.
	origin := BlAffineTransformationCenterOrigin new
]

{ #category : #transformations }
BlTransformationBuilder >> matrix: aMatrix [
	"Note: matrix transformation is not influenced by origin (it is always top left corner or 0@0)"
	transformation addTransformation: ((BlMatrixTransformation matrix: aMatrix) origin: BlAffineTransformationTopLeftOrigin new)
]

{ #category : #origin }
BlTransformationBuilder >> normalizedOrigin: aPoint [
	"Set a normalized position, where top-left is 0@0 and bottom-right is 1@1.
	Negative and greater-than-one values are allowed."

	origin := BlAffineTransformationNormalizedPositionOrigin position: aPoint
]

{ #category : #origin }
BlTransformationBuilder >> origin: anAffineTransformationOrigin [
	"Change transformation origin for all future transformations.
	Note: I do not change origins of already exisiting transformations"

	origin := anAffineTransformationOrigin
]

{ #category : #origin }
BlTransformationBuilder >> rightCenterOrigin [
	self origin: BlAffineTransformationRightCenterOrigin new
]

{ #category : #transformations }
BlTransformationBuilder >> rotateBy: aDegreesAngle [
	transformation addTransformation: (BlRotationTransformation new angle: aDegreesAngle; axis: BlVector zAxis; origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> rotateBy: aDegreesAngle around: aVector [
	transformation addTransformation: (BlRotationTransformation new angle: aDegreesAngle; axis: aVector; origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> scaleBy: aVector [
	| aScaleVector |
	"Append a scaling transformation by a given vector"

	aScaleVector := aVector asScale3D.
	aScaleVector isOne
		ifTrue: [ ^ self ].

	transformation addTransformation: ((BlScalingTransformation scale: aScaleVector) origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> scaleTo: aVector [
	"Replace all existing scaling transformation with a single one
	that takes place of the very first scaling transformation.
	For example, existing transformation list (L1)
		- translate
		- scale X1
		- rotate
		- scale X2
	will be transformed into the following:
		- translate
		- scale Y
		- rotate
	note, how two existing scaling transformation got merged into one"
	
	
]

{ #category : #transformations }
BlTransformationBuilder >> shearBy: aCoefficientPoint [
	transformation addTransformation: ((BlShearTransformation new coefficient: aCoefficientPoint) origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> skewX: anAngleInDegrees [
	transformation addTransformation: ((BlShearTransformation new angleX: anAngleInDegrees) origin: origin)
]

{ #category : #transformations }
BlTransformationBuilder >> skewY: anAngleInDegrees [
	transformation addTransformation: ((BlShearTransformation new angleY: anAngleInDegrees) origin: origin)
]

{ #category : #accessing }
BlTransformationBuilder >> target [
	"Return a target object whose transformation we build"
	<return: #Object>

	^ target
]

{ #category : #accessing }
BlTransformationBuilder >> target: anObject [
	target := anObject
]

{ #category : #origin }
BlTransformationBuilder >> topLeftOrigin [
	self origin: BlAffineTransformationTopLeftOrigin new
]

{ #category : #transformations }
BlTransformationBuilder >> translateBy: aVector [
	"Append a translation transformation by a given vector"
	| aTranslationVector |
	
	aTranslationVector := aVector asTranslate3D.
	aTranslationVector isZero
		ifTrue: [ ^ self ].
	
	transformation addTransformation: ((BlTranslationTransformation translation: aTranslationVector) origin: origin)
]

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
		'origin',
		'target',
		'affineCompositeTransformation'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlTransformationBuilder class >> on: anObject [

	^ self new
		  target: anObject;
		  yourself
]

{ #category : #transformations }
BlTransformationBuilder >> apply [
	"Replace element's transformation chain with our new one that we just have built"

	target transformation:
		(BlElementLocalTransformation newWith: affineCompositeTransformation)
]

{ #category : #origin }
BlTransformationBuilder >> centerOrigin [

	self origin: BlAffineTransformationCenterOrigin defaultInstance
]

{ #category : #transformations }
BlTransformationBuilder >> flipX [

	affineCompositeTransformation addTransformation:
		(BlReflectionTransformation vertical
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> flipY [

	affineCompositeTransformation addTransformation:
		(BlReflectionTransformation horizontal
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> inherit [
	"Append existing element's transformations to the new transformation list"

	target transformation asElementTransformation affineTransformationsDo: [ :each | 
			affineCompositeTransformation addTransformation: each ]
]

{ #category : #initialization }
BlTransformationBuilder >> initialize [

	super initialize.

	affineCompositeTransformation := BlAffineCompositeTransformation new.
	origin := BlAffineTransformationCenterOrigin defaultInstance
]

{ #category : #transformations }
BlTransformationBuilder >> matrix: aMatrix [

	"Note: matrix transformation is not influenced by origin (it is always top left corner or 0@0)"

	affineCompositeTransformation addTransformation:
		((BlMatrixTransformation matrix: aMatrix)
			 origin: BlAffineTransformationTopLeftOrigin new;
			 yourself)
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

	affineCompositeTransformation addTransformation:
		(BlRotationTransformation new
			 angle: aDegreesAngle;
			 axis: BlVector zAxis;
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> rotateBy: aDegreesAngle around: aVector [

	affineCompositeTransformation addTransformation:
		(BlRotationTransformation new
			 angle: aDegreesAngle;
			 axis: aVector;
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> scaleBy: aVector [

	| aScaleVector |
	"Append a scaling transformation by a given vector"
	aScaleVector := aVector asScale3D.
	aScaleVector isOne ifTrue: [ ^ self ].

	affineCompositeTransformation addTransformation:
		((BlScalingTransformation scale: aScaleVector)
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> shearBy: aCoefficientPoint [

	affineCompositeTransformation addTransformation:
		(BlShearTransformation new
			 coefficient: aCoefficientPoint;
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> skewX: anAngleInDegrees [

	affineCompositeTransformation addTransformation:
		(BlShearTransformation new
			 angleX: anAngleInDegrees;
			 origin: origin;
			 yourself)
]

{ #category : #transformations }
BlTransformationBuilder >> skewY: anAngleInDegrees [

	affineCompositeTransformation addTransformation:
		(BlShearTransformation new
			 angleY: anAngleInDegrees;
			 origin: origin;
			 yourself)
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
BlTransformationBuilder >> translateBy: aBlVector [
	"Append a translation transformation by a given vector"

	| aTranslationVector |
	aTranslationVector := aBlVector asTranslate3D.
	aTranslationVector isZero ifTrue: [ ^ self ].

	affineCompositeTransformation addTransformation:
		((BlTranslationTransformation translation: aTranslationVector)
			 origin: origin;
			 yourself)
]

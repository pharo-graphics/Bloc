"
I am special type of animation designed to operate on element's transformation.

Transform animation can be absolute or relative.
(consistent with absolute/relative vector path builder)
 - #relative builds on existing element transformation
 - #absolute defines new element independent transformation

"
Class {
	#name : #BlTransformAnimation,
	#superclass : #BlAnimation,
	#traits : 'TBlTransformable',
	#classTraits : 'TBlTransformable classTrait',
	#instVars : [
		'fromMatrix',
		'toMatrix',
		'isAbsolute',
		'elementTransformation'
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
		elementTransformation := BlElementCompositeTransformation new
			                         add:
				                         self target transformation
					                         asElementTransformation;
			                         add:
				                         elementTransformation
					                         asElementTransformation;
			                         yourself ].
	elementTransformation := elementTransformation asCachedTransformation.

	"matrix depends on computed layout bounds, we should manually trigger layout recomputation"
	
	(self target space isNotNil and: [
		self target space isLayoutRequested ]) ifTrue: [
		self target space doLayout ].

	elementTransformation boundingRectangle:
		self target bounds inLocal asRectangle.

	"Calculate matrix only on start of first loop"
	fromMatrix ifNil: [
		fromMatrix := self target transformation matrix copy.
		toMatrix := elementTransformation matrix ]
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
		  (fromMatrix interpolate: aNumber to: toMatrix)
]

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
		'transformation',
		'fromMatrix',
		'toMatrix',
		'isAbsolute'
	],
	#category : 'Bloc-Animation-Animation'
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

{ #category : #pulse }
BlTransformAnimation >> initStart [
	super initStart.

	isAbsolute
		ifFalse: [
			| aCompositeTransformation |
			aCompositeTransformation := BlElementCompositeTransformation new.
			aCompositeTransformation add: self target transformation.
			aCompositeTransformation add: transformation.
			transformation := aCompositeTransformation ].
	
	transformation owner: self target.
	
	"matrix depends on computed layout bounds, we should manually trigger layout recomputation"
	self target space isLayoutRequested
		ifTrue: [ self target space doLayout ].

	fromMatrix := self target transformation matrix.
	toMatrix := transformation matrix
]

{ #category : #initialization }
BlTransformAnimation >> initialize [
	super initialize.
	
	isAbsolute := false.
	transformation := BlElementLocalTransformation new
]

{ #category : #builder }
BlTransformAnimation >> relative [
	isAbsolute := false
]

{ #category : #transformations }
BlTransformAnimation >> transformation [
	<return: #BlElementTransformation>

	^ transformation
]

{ #category : #transformations }
BlTransformAnimation >> transformation: anElementTransformation [
	transformation := anElementTransformation
]

{ #category : #pulse }
BlTransformAnimation >> valueForStep: aDelta [
	
	"we should recompute destination matrix every step because transformation origins may have changed"
	toMatrix := transformation invalidateMatrix matrix.
	^ BlElementAbsoluteTransformation matrix: (fromMatrix interpolate: aDelta to: toMatrix)
]

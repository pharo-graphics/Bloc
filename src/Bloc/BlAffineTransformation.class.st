"
I am the abstract superclass of all affine transformations that can be applied to a Bloc element: translation, scaling, rotation, reflection, shear, perspective, explicit matrix, and any composition of them.

An affine transformation keeps straight lines straight and parallel lines parallel. It does not necessarily preserve angles or distances, but it does preserve ratios of distances along a line (see https://en.wikipedia.org/wiki/Affine_transformation).

## Responsibility:

- I describe one elementary transformation (or a composition of them) independently of any element.
- I contribute to a transformation matrix by multiplying myself into it, around my origin.
- I know my origin, and whether I am 2D, an identity or a pure translation, so that clients can optimize.

## Collaborators:

- `BlAffineTransformationOrigin` and its subclasses: the point around which I am applied (pivot of a rotation, fixed point of a scaling). By default it is the center of the element (`BlAffineTransformationCenterOrigin`). Others are top-left, left-center, right-center, an absolute position or a normalized position.
- `BlMatrix2D` and `BlMatrix3D`: the matrices I multiply myself into.
- `BlAffineCompositeTransformation`: a sequence of transformations, applied in order.
- `BlTransformationBuilder`: what users normally use to create and chain my instances on an element.
- `BlElementLocalTransformation`: wraps me so that I can be set as an element's transformation.

## Public API and Key Messages

- `#multiplyOn: aBlMatrix` multiplies me into the matrix, ignoring my origin (subclass responsibility).
- `#multiplyOn: aBlMatrix in: aRectangle` translates the matrix to my origin resolved in the element bounds, multiplies me in, then translates back.
- `#asMatrix` answers the `BlMatrix2D` or `BlMatrix3D` equivalent to me, without taking the origin into account.
- `#origin` and `#origin:` access my origin.
- `#is2D` (subclass responsibility), `#is3D`, `#isIdentity`, `#isTranslation`.

Rotation angles are expressed in degrees.

I am abstract. Create one of my subclasses (`BlTranslationTransformation`, `BlScalingTransformation`, `BlRotationTransformation`, `BlReflectionTransformation`, `BlShearTransformation`, `BlPerspectiveTransformation`, `BlMatrixTransformation`, `BlAffineCompositeTransformation`), or, more commonly, let the builder do it:

```
element transformDo: [ :t |
	t topLeftOrigin.
	t scaleBy: 2.
	t rotateBy: 45 ]
```

The same transformation gives a different result depending on its origin. Run `BlAffineTransformation class >> #scriptRotationOrigins` to see a 30 degree rotation applied around three different origins.

## Internal Representation

- `origin`: a `BlAffineTransformationOrigin`, resolved against the bounds of the transformed element when the matrix is computed.

### Implementation Points

- Subclasses must implement `#multiplyOn:` and `#is2D`.
- `#do:` evaluates a block with me, so that a single transformation and a composite one can be enumerated in the same way.
"
Class {
	#name : #BlAffineTransformation,
	#superclass : #Object,
	#instVars : [
		'origin'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #script }
BlAffineTransformation class >> scriptRotationOrigins [
	"The same 30 degree rotation applied with three different origins:
	center (the default), top-left and right-center.
	The first square is the reference: it is displayed without any transformation.
	Each gray frame shows where the square would be without the transformation."

	<script>
	| container squareExtent |
	squareExtent := 60 @ 60.
	container := BlElement new
		             layout: (BlLinearLayout horizontal cellSpacing: 40);
		             padding: (BlInsets all: 40);
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             yourself.

	{
		nil.
		BlAffineTransformationCenterOrigin defaultInstance.
		BlAffineTransformationTopLeftOrigin new.
		BlAffineTransformationRightCenterOrigin new } do: [ :anOriginOrNil |
			| frame square |
			frame := BlElement new
				         extent: squareExtent;
				         border: (BlBorder paint: Color gray width: 1);
				         yourself.
			square := BlElement new
				          extent: squareExtent;
				          background: (Color blue alpha: 0.4);
				          yourself.
			anOriginOrNil ifNotNil: [ :anOrigin |
					square transformation: (BlElementLocalTransformation newWith: (BlRotationTransformation new
								  angle: 30;
								  axis: BlVector zAxis;
								  origin: anOrigin;
								  yourself)) ].
			frame addChild: square.
			container addChild: frame ].

	container openInSpace
]

{ #category : #converting }
BlAffineTransformation >> asMatrix [

	| aMatrix |
	
	aMatrix := self is2D
		ifTrue: [ BlMatrix2D new ]
		ifFalse: [ BlMatrix3D new ].
		
	self multiplyOn: aMatrix.

	^ aMatrix
]

{ #category : #enumerating }
BlAffineTransformation >> do: aBlock [

	aBlock value: self
]

{ #category : #initialization }
BlAffineTransformation >> initialize [

	super initialize.
	
	origin := BlAffineTransformationCenterOrigin defaultInstance
]

{ #category : #testing }
BlAffineTransformation >> is2D [
	"Return true if transformation happens in x-y plane, hence 2D"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlAffineTransformation >> is3D [
	"Return true if transformation happens in x-y-z plane, hence 3D"
	
	^ self is2D not
]

{ #category : #testing }
BlAffineTransformation >> isIdentity [
	"Return true if thiss transformation is identity"
	
	^ false
]

{ #category : #testing }
BlAffineTransformation >> isTranslation [
	"Return true if this transformation is translation"
	
	^ false
]

{ #category : #'mathematical functions' }
BlAffineTransformation >> multiplyOn: aBlMatrix [

	self subclassResponsibility
]

{ #category : #'mathematical functions' }
BlAffineTransformation >> multiplyOn: aBlMatrix in: aBlElement [

	| aBlVector |
	aBlVector := (self origin originIn: aBlElement) asBlocVector.
	
	aBlMatrix translateBy: aBlVector negated.
	self multiplyOn: aBlMatrix.
	aBlMatrix translateBy: aBlVector
]

{ #category : #accessing }
BlAffineTransformation >> origin [

	^ origin
]

{ #category : #accessing }
BlAffineTransformation >> origin: aBlAffineTransformationOrigin [

	origin := aBlAffineTransformationOrigin
]

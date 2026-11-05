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

Run `BlAffineTransformation class >> #scriptDemo` to see every concrete transformation next to an untransformed square, or send `scriptDemo` to one subclass (e.g. `BlRotationTransformation scriptDemo`) to see only that one. Each subclass provides the instance shown through its class-side `#exampleTransformation`.

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

{ #category : #'private - demo' }
BlAffineTransformation class >> demoClasses [
	"Answer the classes shown by #scriptDemo: the receiver when it is concrete, every concrete subclass otherwise"

	^ self isAbstract
		  ifTrue: [ self allSubclasses reject: [ :each | each isAbstract ] ]
		  ifFalse: [ { self } ]
]

{ #category : #'private - demo' }
BlAffineTransformation class >> demoRow [
	"Answer an element showing my name, the reference square without any transformation, and the same square transformed by my #exampleTransformation.
	3D transformations cannot be drawn by the Alexandrie backend yet (see BACKLOG.md), so I show a note instead of the transformed square."

	| transformation row |
	transformation := self exampleTransformation.
	row := BlElement new
		       layout: (BlLinearLayout horizontal interspace: 40);
		       constraintsDo: [ :c |
				       c horizontal fitContent.
				       c vertical fitContent ];
		       clipChildren: false;
		       addChild: (BlTextElement new
				        text: self name asRopedText;
				        constraintsDo: [ :c | c horizontal exact: 260 ];
				        yourself);
		       addChild: (self demoSquareTransformedBy: nil);
		       yourself.
	row addChild: (transformation is2D
			 ifTrue: [ self demoSquareTransformedBy: transformation ]
			 ifFalse: [
					 BlTextElement new
						 text: '3D transformation: not drawable yet' asRopedText;
						 yourself ]).
	^ row
]

{ #category : #'private - demo' }
BlAffineTransformation class >> demoSquareTransformedBy: anAffineTransformationOrNil [
	"Answer a gray frame showing where a square is without transformation, containing that square transformed by the argument (or not transformed when it is nil).
	The red marker in the top-left corner of the square makes reflections and rotations visible.
	The frame does not clip, so the whole transformed square stays visible."

	| square |
	square := BlElement new
		          extent: 60 @ 60;
		          background: (Color blue alpha: 0.4);
		          addChild: (BlElement new
				           extent: 15 @ 15;
				           background: Color red;
				           yourself);
		          yourself.
	anAffineTransformationOrNil ifNotNil: [ :aTransformation |
		square transformation: (BlElementLocalTransformation newWith: aTransformation) ].

	^ BlElement new
		  extent: 60 @ 60;
		  border: (BlBorder paint: Color gray width: 1);
		  clipChildren: false;
		  addChild: square;
		  yourself
]

{ #category : #examples }
BlAffineTransformation class >> exampleTransformation [
	"Answer a configured transformation, shown by #scriptDemo.
	Concrete subclasses must override me. I am abstract and cannot be instantiated,
	so on me I answer a composite transformation, which is also an affine transformation."

	<sampleInstance>
	self isAbstract ifFalse: [ ^ self subclassResponsibility ].
	^ BlAffineCompositeTransformation exampleTransformation
]

{ #category : #testing }
BlAffineTransformation class >> isAbstract [

	^ self == BlAffineTransformation
]

{ #category : #script }
BlAffineTransformation class >> scriptDemo [
	"Show a square displayed without any transformation next to the same square transformed by #exampleTransformation.
	Sent to a concrete subclass (e.g. `BlRotationTransformation scriptDemo`), I show that transformation only.
	Sent to me, the abstract class, I show one row per concrete subclass.
	Subclasses customize the demo by overriding #exampleTransformation."

	<script>
	| container |
	container := BlElement new
		             layout: (BlLinearLayout vertical interspace: 40);
		             padding: (BlInsets all: 40);
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             yourself.
	self demoClasses do: [ :aClass | container addChild: aClass demoRow ].
	container openInSpace
]

{ #category : #script }
BlAffineTransformation class >> scriptRotationOrigins [
	"The same 30 degree rotation applied with three different origins:
	center (the default), top-left and right-center.
	The first square is the reference: it is displayed without any transformation.
	Each gray frame shows where the square would be without the transformation."

	<script>
	| container |
	container := BlElement new
		             layout: (BlLinearLayout horizontal interspace: 40);
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
			container addChild: (self demoSquareTransformedBy: (anOriginOrNil ifNotNil: [ :anOrigin |
							  BlRotationTransformation new
								  angle: 30;
								  axis: BlVector zAxis;
								  origin: anOrigin;
								  yourself ])) ].

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

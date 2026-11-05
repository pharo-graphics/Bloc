"
I am the abstract class of the geometries of a `BlElement`: the shape of the element.

The geometry defines the path that the background fills and that the border strokes,
the area that clips the children (when `clipChildren` is true), and the area that receives mouse events.

### Responsibility
- Build my path on an Alexandrie canvas (`aeApplyTo:element:`), and optionally a specific path for an inside or outside border.
- Adapt myself to the extent of the element (`matchElement:`), which the element sends whenever its extent changes.
- Answer my bounds (`geometryBounds:of:`), my bounds once stroked (`strokedBounds:of:`),
  and whether a point is inside me (`containsPoint:alreadyInGeometryBoundsOf:`).
- Tell whether my path is open, so that it has caps (`hasCaps`), and whether it has corners between segments (`hasJoins`).

### Collaborators
- `BlElement >> #geometry:` installs me. The default geometry of an element is a `BlRectangleGeometry`.
- `BlElementVectorGeometry`: the superclass of almost all geometries, which keeps its own extent and a path cache.
- `BlEmptyGeometry` and `BlRectangleGeometry`, my direct subclasses, take everything from the element and keep no state.
- `BlBorder` and `BlOutskirts` decide how my path is stroked: centered on the path, inside or outside.

### Public API
```
anElement geometry: BlEllipseGeometry new.
anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
anElement geometry: (BlPolygonGeometry vertices: { 0 @ 0. 50 @ 0. 25 @ 40 }).
aGeometry asElement. ""an element with me as geometry and a default look, handy to try me""
```
Run `BlElementGeometry class >> #scriptGeometryKinds` to see all the geometries of Bloc side by side.
Each concrete geometry has an `example...` class method (`<sampleInstance>`), and most have a `script...` one.

### Implementation Points
- My subclasses implement `aeApplyTo:element:`, `matchElement:`, `geometryBounds:of:`, `strokedBounds:of:`,
  `containsPoint:alreadyInGeometryBoundsOf:`, `hasCaps`, `hasJoins` and `releaseStrokedBoundsCache`.
- They usually compare by value (`=`). A geometry that adapts to the extent of its element often compares only its class.
- `pointOnPerimeterOfElement:atRadians:` answers 0 @ 0 by default; only some geometries (rectangle, ellipse, circle, rounded rectangle) redefine it.
- The class side holds the demo helpers (`demoCellFor:caption:`, `demoOpen:`) shared by the scripts of my subclasses.
"
Class {
	#name : #BlElementGeometry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'private - demo' }
BlElementGeometry class >> demoCellFor: anElement caption: aString [
	"Answer anElement in a light gray frame, above aString and the class of its geometry."

	^ self demoCellFor: anElement caption: aString subtitle: anElement geometry class name
]

{ #category : #'private - demo' }
BlElementGeometry class >> demoCellFor: anElement caption: aString subtitle: aSubtitleString [
	"Answer anElement in a light gray frame, above aString and aSubtitleString."

	| frame |
	frame := BlElement new
		         layout: BlFrameLayout new;
		         padding: (BlInsets all: 10);
		         border: (BlBorder paint: Color veryLightGray width: 1);
		         constraintsDo: [ :each |
				         each horizontal fitContent.
				         each vertical fitContent ];
		         yourself.
	frame addChild: anElement.
	^ BlElement new
		  layout: (BlLinearLayout vertical interspace: 6);
		  constraintsDo: [ :each |
				  each horizontal fitContent.
				  each vertical fitContent ];
		  addChildren: {
				  frame.
				  (BlTextElement new text: aString asRopedText).
				  (BlTextElement new text: aSubtitleString asRopedText) };
		  yourself
]

{ #category : #'private - demo' }
BlElementGeometry class >> demoContainer: aCollectionOfCells [
	"Answer an element showing the cells in rows of at most four."

	^ BlElement new
		  layout: (BlGridLayout horizontal
				   columnCount: (aCollectionOfCells size min: 4);
				   cellSpacing: 15;
				   yourself);
		  padding: (BlInsets all: 15);
		  background: Color white;
		  constraintsDo: [ :each |
				  each horizontal fitContent.
				  each vertical fitContent ];
		  addChildren: aCollectionOfCells;
		  yourself
]

{ #category : #'private - demo' }
BlElementGeometry class >> demoElementFor: aGeometry extent: aPoint [
	"Answer an element of extent aPoint shaped by aGeometry, with the default look of `asElement`:
	a gray border, and a translucent gray background for closed geometries."

	^ aGeometry asElement
		  extent: aPoint;
		  yourself
]

{ #category : #'private - demo' }
BlElementGeometry class >> demoGeometryKinds [
	"Answer captions associated with the sample geometries shown by `scriptGeometryKinds`."

	^ { 
		  ('rectangle (default)' -> BlRectangleGeometry exampleRectangle).
		  ('rounded rectangle' -> BlRoundedRectangleGeometry exampleRoundedRectangle).
		  ('ellipse' -> BlEllipseGeometry exampleEllipse).
		  ('circle' -> BlCircleGeometry exampleCircle).
		  ('square' -> BlSquareGeometry exampleSquare).
		  ('stadium' -> BlStadiumGeometry exampleStadium).
		  ('triangle' -> BlTriangleGeometry exampleTriangleTop).
		  ('annulus sector' -> BlAnnulusSectorGeometry exampleAnnulusSector).
		  ('polygon' -> BlPolygonGeometry exampleArrow).
		  ('rounded polygon' -> BlRoundedPolygonGeometry exampleRoundedTriangle).
		  ('histogram' -> BlHistogramGeometry exampleHistogram).
		  ('SVG path' -> BlSvgPath exampleHeart).
		  ('line' -> BlLineGeometry exampleDiagonal).
		  ('polyline' -> BlPolylineGeometry exampleZigZag).
		  ('Bezier curve' -> BlBezierCurveGeometry exampleCubicCurve).
		  ('sigmoid' -> BlSigmoidGeometry exampleSigmoid).
		  ('empty' -> BlEmptyGeometry exampleEmpty) }
]

{ #category : #'private - demo' }
BlElementGeometry class >> demoOpen: aCollectionOfCells [
	"Open a space showing the cells."

	(self demoContainer: aCollectionOfCells) openInSpace
]

{ #category : #script }
BlElementGeometry class >> scriptGeometryKinds [
	"Show the sample instance of each geometry of Bloc, given to an element of 100 x 70.
	Closed geometries are filled in translucent gray; open ones (lines and curves) are only stroked."

	<script>
	self demoOpen: (self demoGeometryKinds collect: [ :each |
			 self
				 demoCellFor: (self demoElementFor: each value extent: 100 @ 70)
				 caption: each key ])
]

{ #category : #converting }
BlElementGeometry >> asElement [
	"Answer an element with me as its geometry, with appropriate default values."

	| anElement |
	anElement := BlElement new
		geometry: self;
		border: (BlBorder paint: Color gray width: 2);
		yourself.

	self hasCaps
		ifTrue: [
			anElement
				background: Color transparent;
				outskirts: BlOutskirts centered ]
		ifFalse: [
			anElement
				background: (Color gray alpha: 0.4) ].

	^ anElement
]

{ #category : #'geometry testing' }
BlElementGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."
	
	^ self subclassResponsibility
]

{ #category : #'api - bounds' }
BlElementGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ self subclassResponsibility
]

{ #category : #testing }
BlElementGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ self subclassResponsibility
]

{ #category : #geometry }
BlElementGeometry >> matchElement: anElement [
	"Adapt me to match the extent of a given element"

	self subclassResponsibility
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterForAnchor: anAnchor [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ self
		  pointOnPerimeterOfElement: anAnchor element
		  atRadians: anAnchor radians - 90 degreesToRadians
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atDegrees: aDegrees [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterOfElement: anElement
		  atRadians: aDegrees degreesToRadians
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" default version that should be redefined according to my perimeter computation "

	^ 0 @ 0
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseCache [
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseStrokedBoundsCache [
	self subclassResponsibility
]

{ #category : #serialization }
BlElementGeometry >> storeOn: aStream [
	aStream nextPutAll: self class name; space; nextPutAll: 'new'
]

{ #category : #'visual bounds' }
BlElementGeometry >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	
	^ self subclassResponsibility
]

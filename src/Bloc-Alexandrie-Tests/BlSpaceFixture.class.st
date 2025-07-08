"
I contain Bloc fixtures.

My methods with unary selectors that start with `build` add elements to a BlSpace.


"
Class {
	#name : #BlSpaceFixture,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'Bloc-Alexandrie-Tests-Utilities'
}

{ #category : #accessing }
BlSpaceFixture class >> allFixtureSelectors [

	^ (self allSelectors
		select: [ :each | (each beginsWith: #build) and: each isUnary ])
		asSortedCollection
]

{ #category : #fixtures }
BlSpaceFixture >> _buildTinyGeometries [
	"It produces random rendering"

	| geometryBlocks outskirts positionGenerator sizes addElementBlock |
	builder spaceExtent: 256 @ 25.

	geometryBlocks := {
		[ BlRectangleGeometry new ].
		[ BlCircleGeometry new ].
		[ BlTriangleGeometry new ].
		[ BlRoundedRectangleGeometry cornerRadius: 0 ].
		[ BlRoundedRectangleGeometry cornerRadius: 4 ].
	}.
	sizes := {
		0 asPoint. 1 asPoint.
		1@0. 0@1 }.
	outskirts := {
		BlOutskirts centered.
		BlOutskirts inside.
		BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 3 asPoint
		by: 4
		columns: 63.

	"Reusable block to add each element"
	addElementBlock := [ :aGeometry :aBorder :anOutskirt |
		sizes do: [ :eachSize |
			builder addToRoot
				background: Color black;
				position: positionGenerator next;
				size: eachSize;
				geometry: aGeometry;
				border: aBorder;
				yourself ] ].

	"Add variants of each geometry"
	geometryBlocks do: [ :eachBlock |
		addElementBlock
			value: eachBlock value
			value: BlBorder empty
			value: BlOutskirts centered.
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: eachBlock value
				value: (BlBorder paint: Color cyan width: 1)
				value: eachOutskirt ].
		outskirts do: [ :eachOutskirt |
			addElementBlock
				value: eachBlock value
				value: (BlBorder paint: Color green width: 2)
				value: eachOutskirt ] ]

]

{ #category : #fixtures }
BlSpaceFixture >> buildCapRoundDashedBorderOnClosedGeometry [
	"Related to https://github.com/pharo-graphics/Bloc/issues/200"

	| outskirts radius borderWidth dashes lineCaps |
	radius := 14.
	borderWidth := 6.
	dashes := { 0. (Float twoPi * radius)/9 }.

	builder spaceExtent: 130 @ 130.
	builder space root layout: BlFlowLayout horizontal.

	outskirts := {
		BlOutskirts centered.
		BlOutskirts inside.
		BlOutskirts outside }.
	lineCaps := {
		BlStrokeLineCap round.
		BlStrokeLineCap square.
		BlStrokeLineCap butt. }.

	lineCaps do: [ :eachLineCap |
		outskirts do: [ :eachOutskirt |
			builder addCircle
				outskirts: eachOutskirt;
				margin: (BlInsets top: 12 left: 12);
				size: (radius*2) asPoint;
				border: (BlBorder builder
					paint: Color black;
					width: borderWidth;
					dashArray: dashes;
					lineCap: eachLineCap;
					build) ] ]

]

{ #category : #fixtures }
BlSpaceFixture >> buildChildDoesntInheritDashedBorder [

	| outskirts |
	builder spaceExtent: 90 @ 50.
	builder space root layout: BlFlowLayout horizontal.

	outskirts := {
		BlOutskirts centered.
		BlOutskirts inside.
		BlOutskirts outside }.

	#(true false) do: [ :childHasBorder |
		outskirts do: [ :eachOutskirt |
			| parent child |
			parent := builder addToRoot
				size: 25 @ 20;
				margin: (BlInsets all: 2.5);
				outskirts: eachOutskirt;
				layout: BlFrameLayout new;
				border: (BlBorder builder
					paint: Color blue;
					width: 2;
					dashArray: #(2 2);
					build).
			child := (builder addTo: parent)
				size: 12 asPoint;
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			childHasBorder ifTrue: [
				child border: (BlBorder paint: Color white width: 4) ] ] ]

]

{ #category : #fixtures }
BlSpaceFixture >> buildClippingAbsolutelyTransparentElement [
	"Add 3 elements, where only the last one should be clipped by it's transparent parent.
	The output should be a blue rectangle surrounded by orange."

	| parent child grandChild |
	"Far enough extent"
	builder spaceExtent: 25 asPoint.

	parent := builder addToRoot
		background: BlBackground transparent;
		position: 5 asPoint;
		size: 10 asPoint;
		clipChildren: false;
		yourself.

	child := (builder addTo: parent)
		background: BlBackground transparent;
		position: 5 asPoint;
		size: 10 asPoint;
		clipChildren: true;
		yourself.
	
	grandChild := (builder addTo: child)
		background: Color blue;
		position: 5 asPoint;
		size: 50 asPoint;
		yourself.
	
	builder space root background: Color orange

]

{ #category : #fixtures }
BlSpaceFixture >> buildClippingMany [

	| newElementBlock elementSize |
	elementSize := 200 asPoint.

	newElementBlock := [ :parentElement :depth |
		| anElement |
		anElement :=
			(builder addTo: parentElement)
				geometry: BlCircleGeometry new;
				size: elementSize;
				transformDo: [ :t | t topLeftOrigin; scaleBy: 0.5 ];
				border: (BlBorder paint: Color black width: 5);
				background: (depth odd
					ifTrue: [ Color green muchDarker ]
					ifFalse: [ Color red muchDarker ]);
				clipChildren: depth odd;
				yourself.
			
			depth > 0 ifTrue: [
				(newElementBlock value: anElement value: depth-1).
				(newElementBlock value: anElement value: depth-1) position: elementSize/2 ].
			
			anElement ].
	
	newElementBlock value: builder space root value: 4.

]

{ #category : #fixtures }
BlSpaceFixture >> buildClippingOutskirts [

	| outskirts width positionGenerator addElementsBlock |
	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	width := 5.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 8 asPoint
		by: 25
		columns: 3.
	addElementsBlock := [ :anOutskirt :aColor |
		| element child |
		element := builder addCircle
			background: aColor;
			border: (BlBorder paint: builder nextColor width: width);
			outskirts: anOutskirt;
			position: positionGenerator next;
			size: 35 asPoint;
			yourself.
		child := (builder addTo: element)
			size: 20 asPoint;
			position: -2 asPoint;
			border: (BlBorder paint: Color yellow width: 1);
			yourself.
		(builder addTo: child)
			size: 20 asPoint;
			position: 10 asPoint;
			geometry: BlCircleGeometry new;
			border: (BlBorder paint: Color red width: 1);
			yourself ].

	"Opaques"
	outskirts do: [ :eachOutskirt |
		addElementsBlock
			value: eachOutskirt
			value: builder nextColor ].

	"Translucents"
	outskirts do: [ :eachOutskirt |
		addElementsBlock
			value: eachOutskirt
			value: builder nextColor translucent ].

	"Transparents"
	outskirts do: [ :eachOutskirt |
		addElementsBlock
			value: eachOutskirt
			value: Color transparent ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildClippingWithoutBorders [

	| elementA elementB elementC |

	elementA := builder addToRoot
		geometry: BlRectangleGeometry new;
		position: 10 asPoint;
		size: 10 asPoint;
		clipChildren: false;
		yourself.

	elementB := (builder addTo: elementA)
		geometry: BlRectangleGeometry new;
		position: 5 asPoint;
		size: 10 asPoint;
		clipChildren: true;
		yourself.
		
	elementC := (builder addTo: elementB)
		geometry: BlRectangleGeometry new;
		position: 5 asPoint;
		size: 10 asPoint;
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildCompositeEffect [

	| element compositeEffect |
	builder spaceExtent: 45 @ 60.

	element := builder addToRoot
		background: Color black translucent;
		position: 10 @ 15;
		size: 20@30;
		yourself.

	compositeEffect := BlCompositeEffect effects: {
		BlGaussianShadowEffect color: Color red width: 3 offset: 7 @ 11.
		BlGaussianShadowEffect color: Color green width: 7 offset: -5 @ 7.
		BlGaussianShadowEffect color: Color blue width: 11 offset: 7 @ -5 }.

	element effect: compositeEffect.

]

{ #category : #fixtures }
BlSpaceFixture >> buildDashesInsideAndOutsideBuggyForPolygon [
	"Register this undesired rendering in some geometries with dashed border and outside or inside outskirts"

	| outskirts |
	builder spaceExtent: 150@50.
	builder space root layout: BlFlowLayout horizontal.

	outskirts := {
		BlOutskirts centered. "This is the only well rendered"
		BlOutskirts inside.
		BlOutskirts outside }.

	outskirts do: [ :eachOutskirt |
		builder addHexagonalPolygon
			outskirts: eachOutskirt;
			margin: (BlInsets all: 7);
			size: 35 asPoint;
			transformDo: [ :t |
				t topLeftOrigin; scaleBy: 0.5 ];
			border: (BlBorder builder
				paint: Color black;
				width: 10;
				dashArray: #(10 20);
				capSquare;
				build) ]

]

{ #category : #fixtures }
BlSpaceFixture >> buildDashesInsideAndOutsideOkayForCircle [
	"Geometries that establish a `AeCanvas>>#borderPathFactory:` in the canvas work well."

	| outskirts |
	builder spaceExtent: 130@50.
	builder space root layout: BlFlowLayout horizontal.

	outskirts := {
		BlOutskirts centered.
		BlOutskirts inside.
		BlOutskirts outside }.

	outskirts do: [ :eachOutskirt |
		builder addCircle
			outskirts: eachOutskirt;
			margin: (BlInsets top: 10 left: 10);
			size: 30 asPoint;
			border: (BlBorder builder
				paint: Color black;
				width: 5;
				dashArray: #(5 10);
				capSquare;
				build) ]

]

{ #category : #fixtures }
BlSpaceFixture >> buildElevation [

	| elementA elementB elementC childD childE childF |

	"A and children are on top"
	elementA := builder addCircle
		elevation: (BlRelativeElevation elevation: 101);
		position: 10@10;
		clipChildren: false;
		yourself.

	"B is below A"
	elementB := builder addCircle
		elevation: (BlGlobalElevation elevation: 90);
		position: 25@10;
		yourself.

	"C is below A"
	elementC := builder addCircle
		elevation: (BlGlobalElevation elevation: 100);
		position: 50@10;
		yourself.


	"D is below E, since 'relative' means relative to 0. 
	--> Bug? If it would be relative to its parent, it would
	be 101+5 => D would overlap E"
	childD := (builder addTo: elementA)
		elevation: (BlRelativeElevation elevation: 5);
		position: 10 @ 10;
		size: 30 asPoint;
		yourself.

	"Large elevation of a child doesn't mean it will overlap other
	elements than siblings"
	childE := (builder addTo: elementA)
		elevation: (BlGlobalElevation elevation: 102);
		position: 20 @ 20;
		size: 30 asPoint;
		yourself.

	"F goes below all siblings"
	childF := (builder addTo: elementA)
		elevation: (BlRelativeElevation elevation: -10);
		position: 30 @ 30;
		size: 30 asPoint;
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildEmptyGeometry [
	"Note: green rectangle never shows, and blue only when clipping is OFF."

	| a b c d e f |
	"1st: Clipping ON"
	a := builder addToRoot
		position: 0 asPoint;
		size: 50 asPoint;
		background: Color red.
	b := (builder addTo: a)
		geometry: BlEmptyGeometry new;
		clipChildren: true;
		size: 40 asPoint;
		background: Color green.
	c := (builder addTo: b)
		size: 30 asPoint;
		background: Color blue.

	"2nd: Same pattern, but clipping OFF."
	d := builder addToRoot
		position: 50 asPoint;
		size: 50 asPoint;
		background: Color red.
	e := (builder addTo: d)
		clipChildren: false;
		geometry: BlEmptyGeometry new;
		size: 40 asPoint;
		background: Color green.
	f := (builder addTo: e)
		size: 30 asPoint;
		background: Color blue.

]

{ #category : #fixtures }
BlSpaceFixture >> buildGaussianShadowsByCircleSector [

	self buildVariantsOfCircleSectorAnglesCustomizedWith: [ :each |
		each effect:
			(BlGaussianShadowEffect
					color: Color green
					width: 4.5
					offset: -2 @ 3) ] 
]

{ #category : #fixtures }
BlSpaceFixture >> buildGaussianShadowsByGeometry [

	| positionGenerator addElementBlock cellSize numberOfColumns shadowSize elementSize geometryBlocks |
	shadowSize := 2.
	elementSize := 12.
	cellSize := elementSize * 1.75.
	numberOfColumns := 4.
	geometryBlocks := {
		[ BlRectangleGeometry new ].
		[ BlCircleGeometry new ].
		[ BlTriangleGeometry new ].
		[ BlTriangleGeometry new beTop; yourself ].
		[ BlRoundedRectangleGeometry cornerRadius: 3 ].
		[ BlPolygonGeometry vertices: { 0 asPoint. 0@elementSize. elementSize @ 0 } ].
	}.
	"Establish the extent of the canvas based on parameters"
	builder spaceExtent:
		((cellSize * numberOfColumns) @
		 (cellSize * geometryBlocks size)).

	"Raw grid layout"
	positionGenerator := self
		gridPositionGeneratorStartingAt: 5 asPoint
		by: cellSize
		columns: numberOfColumns.

	"Reusable block to add each element"
	addElementBlock := [ :aGeometry :backgroundAlpha :shadowAlpha :shadowOffset |
		builder addToRoot
			geometry: aGeometry;
			position: positionGenerator next;
			size: elementSize asPoint;
			background: (Color blue alpha: backgroundAlpha);
			effect: (BlGaussianShadowEffect
					color: (Color orange alpha: shadowAlpha)
					width: 4
					offset: shadowOffset);
			yourself ].

	"Add variants of each geometry"
	geometryBlocks do: [ :eachBlock |

		"Both opaque, background and shadow"
		addElementBlock
			value: eachBlock value
			value: 1.0
			value: 1.0
			value: shadowSize @ shadowSize.

		"Translucent shadow"
		addElementBlock
			value: eachBlock value
			value: 1.0
			value: 0.6
			value: shadowSize negated @ shadowSize.

		"Both translucent"
		addElementBlock
			value: eachBlock value
			value: 0.6
			value: 0.6
			value: shadowSize @ shadowSize negated.

		"Translucent background and opaque shadow (a strange case)"
		addElementBlock
			value: eachBlock value
			value: 0.6
			value: 1.0
			value: 0 @ shadowSize.

		]

]

{ #category : #fixtures }
BlSpaceFixture >> buildGaussianShadowsByOutskirt [

	self buildVariantsOfOutskirtCustomizedWith: [ :anElement |
		anElement effect:
				(BlGaussianShadowEffect
					color: Color blue
					width: 10
					offset: 18) ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildGaussianShadowsByStrokeStyle [

	self buildStrokeStyleCustomizedWith: [ :each |
		each effect:
			(BlGaussianShadowEffect
				color: Color orange
				width: 4
				offset: 0 @ -4) ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildGaussianShadowsByTextTransformations [

	self buildTextTransformationsCustomizedWith: [ :each |
		each effect:
			(BlGaussianShadowEffect
				color: Color orange darker
				width: 3
				offset: 0@0 ) ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildGeometriesAsElement [

	| geometries container |
	builder spaceExtent: ((12@12) * (3@4)) + (3@3).

	container :=
	  builder addToRoot
	    layout: (BlGridLayout horizontal
			columnCount: 3;
			cellSpacing: 2;
			yourself);
	    constraintsDo: [ :c |
			c margin: (BlInsets top: 3 left: 3).
	      c horizontal matchParent.
	      c vertical matchParent ];
	    yourself.

	geometries := {
		BlEmptyGeometry new.
		BlPolygonGeometry vertices: { 0@0. 10@0. 10@10. 0@10 }.
		BlPolylineGeometry vertices: { 0@0. 10@0. 10@10. 0@10 }.
		BlLineGeometry from: 0@0 to: 10@10.
		BlBezierCurveGeometry controlPoints: { 0@0. 10@10 }.
		BlEllipseGeometry new.
		BlCircleGeometry new.
		BlTriangleGeometry new.
		BlSquareGeometry new.
		BlRectangleGeometry new.
		BlRoundedRectangleGeometry cornerRadius: 3.
		BlAnnulusSectorGeometry new }.

	geometries do: [ :each |
		| anElement |
		anElement := each asElement.
		anElement size: 10@10.
		container addChild: anElement ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildGradients [

	| aLinearGradient aRadialGradient anExtent |

	"Bug? start and stop only give the direction."
	aLinearGradient := BlLinearGradientPaint new
			start: 0@10;
			end: 10@0;
			stops: {
				0.2 -> (Color black alpha: 0.7).
				0.8 -> (Color orange alpha: 0.9) };
			yourself.

	aRadialGradient := BlRadialGradientPaint new
			innerCenter:  30 asPoint;
			innerRadius:  0;
			outerCenter: 30 asPoint;
			outerRadius: 20;
			stops: {
				0.0 -> Color yellow.
				0.4 -> Color white.
				0.7 -> Color blue.
				0.9 -> Color transparent.
				1.0 -> (Color green alpha: 0.2) };
			yourself.

	anExtent := 100 asPoint.
	builder addToRoot
		size: anExtent;
		background: aLinearGradient.
	builder addToRoot
		size: anExtent;
		background: aRadialGradient.
	builder spaceExtent: anExtent.

]

{ #category : #fixtures }
BlSpaceFixture >> buildGradientsInBorder [

	| aLinearGradient aRadialGradient extent borderWidth |
	extent := 20 @ 30.
	borderWidth := extent x // 3.

	aLinearGradient := BlLinearGradientPaint new
			start: 0@0;
			end: 0 @ extent y;
			stops: {
				0.0 -> Color blue.
				0.3 -> Color yellow.
				1.0 -> Color transparent };
			yourself.
	builder addToRoot
		beOutskirtsCentered;
		position: extent // 5;
		size: extent;
		background: (Color orange alpha: 0.75);
		border: (BlBorder paint: aLinearGradient width: borderWidth).

	aRadialGradient := BlRadialGradientPaint new
			innerCenter:  extent;
			innerRadius:  0;
			outerCenter: extent;
			outerRadius: extent x;
			stops: {
				0.0 -> Color blue.
				0.3 -> Color yellow.
				1.0 -> Color transparent };
			yourself.
	builder addToRoot
		beOutskirtsCentered;
		position: extent * 0.75;
		size: extent;
		background: (Color green alpha: 0.75);
		border: (BlBorder paint: aRadialGradient width: borderWidth).

	builder spaceExtent: extent * 2
]

{ #category : #fixtures }
BlSpaceFixture >> buildHistogram [

	| ramp orientations |
	ramp := 0 to: 1 by: 0.2.
	orientations := #(#beHorizontal beVertical beVerticalInverted #beHorizontalInverted).

	builder spaceExtent: 10 * orientations size @ 20.
	builder space root layout: BlLinearLayout horizontal.

	orientations withIndexDo: [ :each :index |
			| g |
			g := BlHistogramGeometry values: ramp.
			g perform: each.

			builder addToRoot
				width: 10;
				height: 20;
				background: builder nextColor;
				geometry: g ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildImagesAndTransformations [
	
	| outskirts positionGenerator addElementBlock |

	builder spaceExtent: 120@250.

	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 5 asPoint
		by: 26
		columns: 4.
	addElementBlock := [ | aForm |
		aForm := Smalltalk ui icons iconNamed: #warning.
		builder addCircle
			background: aForm;
			position: positionGenerator next;
			size: aForm extent;
			yourself ].


	"Translate"
	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t translateBy: (each * 2 - 4) asPoint ] ].

	"Rotate"
	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t centerOrigin. "default"
			t rotateBy: each * 45 ] ].

	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t topLeftOrigin.
			t rotateBy: each * 45 ] ].

	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t rightCenterOrigin.
			t rotateBy: each * 45 ] ].


	"Scale"			
	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t centerOrigin. "default"
			t scaleBy: each * 0.25 ] ].

	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t topLeftOrigin.
			t scaleBy: each * 0.25 ] ].

	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t rightCenterOrigin.
			t scaleBy: each * 0.25 ] ].

	"Some combinations"
	1 to: 4 do: [ :each |
		addElementBlock value transformDo: [ :t |
			t scaleBy: each * 0.2.
			t translateBy: (each * 2 - 4) asPoint.
			t rotateBy: each * 45.
			t translateBy: (each * 2 - 4) negated asPoint ] ].

	"Others"
	addElementBlock value transformDo: [ :t |
		t flipX ].
	addElementBlock value transformDo: [ :t |
		t flipY ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildLinearLayoutWithPaddingAndMargin [

	| container |
	container :=
	  builder addToRoot
	    layout: (BlLinearLayout vertical cellSpacing: 5);
	    padding: (BlInsets all: 10);
	    constraintsDo: [ :c |
	      c horizontal exact: 80.
	      c vertical matchParent ];
	    yourself.

	(builder addTo: container)
		background: Color orange;
	    constraintsDo: [ :c |
	      c horizontal matchParent.
			c vertical exact: 20 ];
		yourself.

	(builder addTo: container)
		background: Color blue;
	   constraintsDo: [ :c |
	      c horizontal matchParent.
			c vertical exact: 10 ];
		margin: (BlInsets horizontal: 10);
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildMiddleAlignedGeometriesHorizontal [

	| geometries container extent borderSize outskirts containerExtent |
	extent := 24 @ 12.
	borderSize := 3.
	outskirts := { 
		BlOutskirts inside.
		BlOutskirts centered.
		BlOutskirts outside }.
	geometries := { 
		BlSquareGeometry new.
		BlCircleGeometry new.
		BlAnnulusSectorGeometry new }.

	containerExtent :=
		Point
			x: extent x
			y: extent y * geometries size * outskirts size + borderSize.
	builder spaceExtent: containerExtent.

	container :=
		builder addToRoot
			clipChildren: false;
			width: containerExtent x	 / 2;
			height: containerExtent y;
			background: (Color blue alpha: 0.2);
			yourself.

	outskirts withIndexDo: [ :eachOutskirts :outskirtIndex |
		geometries withIndexDo: [ :eachGeometry :geometryIndex |
		  container addChild:  
				(BlElement new
		         geometry: eachGeometry;
					outskirts: eachOutskirts;
		         background: Color orange translucent;
		         border:
						(BlBorder
							paint: Color black translucent
							width: borderSize);
		         constraintsDo: [:constraints |
		            constraints horizontal exact: extent x.
		            constraints vertical exact: extent y.
		            constraints position:
							(Point
								x: 0
								y: (extent y * (
									(geometryIndex-1) +
									(geometries size * (outskirtIndex-1))))) ];
		         yourself) ] ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildOpacities [

	| size fillColor borderColor |
	size := 50 asPoint.
	fillColor := builder nextColor.
	borderColor := builder nextColor.
	
	builder addToRoot
		background: ((BlPaintBackground paint: fillColor asBlPaint) opacity: 0.75; yourself);
		opacity: 0.5;
		position: 10 @ 10;
		size: size;
		yourself.

	builder addToRoot
		background: ((BlPaintBackground paint: fillColor) opacity: 0.5; yourself);
		opacity: 0.75;
		position: 40 @ 10;
		size: size;
		yourself.

	builder addToRoot
		background: fillColor;
		border: (BlBorder builder
			paint: (borderColor alpha: 0.75) asBlPaint;
			width: 10;
			opacity: 0.5;
			build);
		position: 10 @ 40;
		size: size;
		yourself.

	builder addToRoot
		background: fillColor;
		border: (BlBorder builder
			paint: (borderColor alpha: 0.5) asBlPaint;
			width: 10;
			opacity: 0.75;
			build);
		position: 40 @ 40;
		size: size;
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildOutskirtsAndOpaqueBorders [

	| outskirts positionGenerator addElementBlock |
	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 8 asPoint
		by: 25
		columns: 3.
	addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
		builder addCircle
			background: backgroundColor;
			border: (BlBorder paint: borderColor width: 5);
			outskirts: aBlOutskirt;
			position: positionGenerator next;
			size: 35 asPoint;
			yourself ].
		
	"Opaques"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor
			value: builder nextColor
			value: eachOutskirt ].

	"Translucents"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor translucent
			value: builder nextColor
			value: eachOutskirt ].

	"Transparents"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: Color transparent
			value: builder nextColor
			value: eachOutskirt ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildOutskirtsAndTranslucentBorders [

	| outskirts positionGenerator addElementBlock |
	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 8 asPoint
		by: 25
		columns: 3.
	addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
		builder addCircle
			background: backgroundColor;
			border: (BlBorder paint: borderColor width: 5);
			outskirts: aBlOutskirt;
			position: positionGenerator next;
			size: 35 asPoint;
			yourself ].
		
	"Opaques + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor
			value: builder nextColor translucent
			value: eachOutskirt ].

	"Translucents + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor translucent
			value: builder nextColor translucent
			value: eachOutskirt ].

	"Transparents + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: Color transparent
			value: builder nextColor translucent
			value: eachOutskirt ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildOutskirtsOfPolygons [

	| outskirts width scale positionGenerator |
	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	width := 7.
	scale := 0.5.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 9 @ 14
		by: 20
		columns: 3.

	"Opaques"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				position: positionGenerator next;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t topLeftOrigin; scaleBy: scale ];
				yourself ].

	"Translucents"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				position: positionGenerator next;
				background: builder nextColor translucent;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t topLeftOrigin; scaleBy: scale ];
				yourself ].

	"Transparents"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				position: positionGenerator next;
				background: Color transparent;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t topLeftOrigin; scaleBy: scale ];
				yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingCircles [

	| elementA elementB |

	elementA := builder addCircle
		position: 10 asPoint;
		size: 10 asPoint;
		yourself.

	elementB := builder addCircle
		position: 15 asPoint;
		size: 10 asPoint;
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingRectangles [
	"Note: This code assumes that default geometry is a rectangle."

	builder addToRoot
		position: 10 asPoint;
		size: 10 asPoint.

	builder addToRoot
		position: 15 asPoint;
		size: 10 asPoint.

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingTriangles [

	| elementA elementB |

	elementA := builder addToRoot
		geometry: BlTriangleGeometry new;
		position: 10 asPoint;
		size: 10 asPoint;
		yourself.

	elementB := builder addToRoot
		geometry: BlTriangleGeometry new;
		position: 15 asPoint;
		size: 10 asPoint;
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildSimpleShadowsByCircleSector [

	self buildVariantsOfCircleSectorAnglesCustomizedWith: [ :each |
		each effect:
			(BlSimpleShadowEffect
				color: Color green
				offset: -2 @ 3 ) ] 
]

{ #category : #fixtures }
BlSpaceFixture >> buildSimpleShadowsByGeometry [

	| positionGenerator addElementBlock cellSize numberOfColumns shadowSize elementSize geometryBlocks |
	shadowSize := 2.
	elementSize := 12.
	cellSize := elementSize * 1.75.
	numberOfColumns := 4.
	geometryBlocks := {	[ BlRectangleGeometry new ].
		[ BlCircleGeometry new ].
		[ BlTriangleGeometry new ].
		[ BlTriangleGeometry new beTop; yourself ].
		[ BlRoundedRectangleGeometry cornerRadius: 3 ].
		[ BlPolygonGeometry vertices: { 0 asPoint. 0@elementSize. elementSize @ 0 } ].
	}.
	"Establish the extent of the canvas based on parameters"
	builder spaceExtent:
		((cellSize * numberOfColumns) @
		 (cellSize * geometryBlocks size)).

	"Raw grid layout"
	positionGenerator := self
		gridPositionGeneratorStartingAt: 5 asPoint
		by: cellSize
		columns: numberOfColumns.

	"Reusable block to add each element"
	addElementBlock := [ :aGeometry :backgroundAlpha :shadowAlpha :shadowOffset |
		builder addToRoot
			geometry: aGeometry;
			position: positionGenerator next;
			size: elementSize asPoint;
			background: (Color blue alpha: backgroundAlpha);
			effect: (BlSimpleShadowEffect
				color: (Color orange alpha: shadowAlpha)
				offset: shadowOffset);
			yourself ].

	"Add variants of each geometry"
	geometryBlocks do: [ :eachBlock |

		"Both opaque, background and shadow"
		addElementBlock
			value: eachBlock value
			value: 1.0
			value: 1.0
			value: shadowSize @ shadowSize.

		"Translucent shadow"
		addElementBlock
			value: eachBlock value
			value: 1.0
			value: 0.6
			value: shadowSize negated @ shadowSize.

		"Both translucent"
		addElementBlock
			value: eachBlock value
			value: 0.6
			value: 0.6
			value: shadowSize @ shadowSize negated.

		"Translucent background and opaque shadow (a strange case)"
		addElementBlock
			value: eachBlock value
			value: 0.6
			value: 1.0
			value: 0 @ shadowSize.

		]

]

{ #category : #fixtures }
BlSpaceFixture >> buildSimpleShadowsByOutskirt [

	self buildVariantsOfOutskirtCustomizedWith: [ :anElement |
		anElement effect:
				(BlSimpleShadowEffect
					color: Color black
					offset: 18) ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildSimpleShadowsByStrokeStyle [

	self buildStrokeStyleCustomizedWith: [ :each |
		each effect:
			(BlSimpleShadowEffect
				color: Color orange
				offset: 0 @ -2) ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildSimpleShadowsByTextTransformations [

	self buildTextTransformationsCustomizedWith: [ :each |
		each effect:
			(BlSimpleShadowEffect
				color: Color orange
				offset: 1 @ 1 ) ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildStrokeStyleCustomizedWith: aBlock [

	self buildStrokeStyles.

	builder space root allChildrenDepthFirstDo: aBlock
]

{ #category : #fixtures }
BlSpaceFixture >> buildStrokeStyles [

	| positionGenerator width |
	width := 9.
	positionGenerator := self
		diagonalPositionGeneratorStartingAt: 7
		by: 14.

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capButt;
			joinRound;
			paint: builder nextColor;
			build).

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capSquare;
			joinBevel;
			paint: builder nextColor;
			build).

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capRound;
			joinMiter;
			miterLimit: 10;
			paint: builder nextColor;
			build).

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			dashArray: #(0 5);
			capRound;
			joinRound;
			paint: builder nextColor;
			width: 4;
			build).

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			dashArray: #(3 5);
			dashOffset: 5;
			paint: builder nextColor;
			capSquare;
			joinBevel;
			width: 3;
			build).

	builder addPolyline
		position: positionGenerator next;
		border: (BlBorder builder
			paint: builder nextColor;
			capSquare;
			joinMiter;
			miterLimit: 1; "This will make it render as bevel join"
			width: 12;
			build);
		transformDo: [ :t |
			t translateBy: -10 asPoint.
			t scaleBy: 0.8. ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextAttributes [

	| container |
	builder spaceExtent: 50 @ 100.

	container :=
	  builder addToRoot
	    layout: (BlLinearLayout vertical cellSpacing: 5);
	    constraintsDo: [ :c |
	      c horizontal matchParent.
	      c vertical matchParent ];
	    yourself.
	
	builder
		addText: ((self ropedTextFor: 'Les')
			fontSize: 40;
			fontName: self monospacedFontFamilyName;
			foreground: Color blue;
			yourself)
		to: container.

	builder
		addText: ((self ropedTextFor: 'élèves')
			fontSize: 30;
			underline;
			yourself)
		to: container.
		
	builder
		addText: ((self ropedTextFor: 'français')
			fontSize: 25;
			background: Color yellow;
			yourself)
		to: container.
]

{ #category : #fixtures }
BlSpaceFixture >> buildTextEmoji [

	| emojiFont emojiString |
	self flag: #todo.
	emojiFont := AeNotoColorEmojiDownloadedFont new.
	(AeFontManager globalInstance
		includesFamilyName: emojiFont familyName) ifFalse: [
			"Baseline ensured to download it, but after reopening
			the image, we may require a new scan."
			AeFontManager resetGlobalInstance.
			AeFontManager globalInstance
				scanDirectory: AeFilesystemResources fontsDirectory ].

	builder spaceExtent: 200 @ 80.

	emojiString := WideString streamContents: [ :stream |
		#(16r1F44D 16r1f642 16r1F525 ) do: [ :each |
			stream nextPut: (Unicode value: each) ]].

	builder
		addTextToRoot: (emojiString asRopedText
			fontName: emojiFont familyName;
			fontSize: 50;
			yourself).


]

{ #category : #fixtures }
BlSpaceFixture >> buildTextMeasurements [

	| container |
	builder spaceExtent: 200 @ 25.

	container :=
	  builder addToRoot
	    layout: (BlLinearLayout horizontal cellSpacing: 1);
	    constraintsDo: [ :c |
	      c horizontal matchParent.
	      c vertical matchParent ];
		 transformDo: [ :t |
			"Zoom in, to better appreciate children details"
			t topLeftOrigin; scaleBy: 1.5 ];
	    yourself.

	#(editorMeasurement labelMeasurement tightMeasurement)
		do: [ :eachSelector |

			(builder addText: (self ropedTextFor: 'Agüita') to: container)
				background: builder nextColor;
				perform: eachSelector
				yourself.
			
			]

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextOpacities [

	| container |
	builder spaceExtent: 50 @ 100.

	container :=
	  builder addToRoot
	    layout: (BlLinearLayout vertical cellSpacing: 1);
	    constraintsDo: [ :c |
	      c horizontal matchParent.
	      c vertical matchParent ];
		 transformDo: [ :t |
			"Zoom in, to better appreciate children details"
			t topLeftOrigin; scaleBy: 2 ];
	    yourself.

  (builder
		addText: ((self ropedTextFor: 'aßc')
		    foreground: (Color black alpha: 1.0);
		    yourself)
		to: container)
		opacity: 1.0.

  (builder
		addText: ((self ropedTextFor: 'aßc')
		    foreground: (Color black alpha: 1.0);
		    yourself)
		to: container)
		opacity: 0.5.

  (builder
		addText: ((self ropedTextFor: 'aßc')
		    foreground: (Color black alpha: 0.5);
		    yourself)
		to: container)
		opacity: 1.0.

  (builder
		addText: ((self ropedTextFor: 'aßc')
		    foreground: (Color black alpha: 0.5);
		    yourself)
		to: container)
		opacity: 0.5.

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextTransformations [

	(builder addTextToRoot: (self ropedTextFor: '¡Hola!'))
		transformDo: [ :t |
			t scaleBy: 1.5.
			"rotation at bottom-left:"
			t normalizedOrigin: 0 @ 1.
			t skewY: 15.
			t rotateBy: 90 ].

	(builder addTextToRoot: (self ropedTextFor: 'Salut !'))
		transformDo: [ :t |
			"rotation beyond top-right:"
			t normalizedOrigin: 1.5 @ -1.5.
			t rotateBy: -45.
			t scaleBy: 2. ].

	(builder addTextToRoot: (self ropedTextFor: 'Hello!'))
		position: 50 asPoint;
		transformDo: [ :t |
			t translateBy: 15 asPoint.
			t skewX: 45 ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextTransformationsCustomizedWith: aBlock [

	self buildTextTransformations.
	
	builder space root allChildrenDepthFirstDo: aBlock
]

{ #category : #fixtures }
BlSpaceFixture >> buildTextWithBorder [
	"Each character has different border attribute."

	| aText |
	builder spaceExtent: 90 @ 40.

	aText := 'BLOC' asRopedText.

	1 to: aText size do: [ :index |
		(aText from: index to: index)
			fontSize: 40 - (index * 3);
			foreground: builder nextColor muchLighter;
			background: builder nextColor;
			border: (BlBorder
				paint: builder nextColor muchDarker
				width: index * 1.5) ].

	(builder addTextToRoot: aText)
		padding: (BlInsets all: 5)

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextWithBorderAbove [
	"Text border can be drawn above or below the text."

	| aText |
	builder spaceExtent: 60 @ 100.

	aText :=
		'll' asRopedText
			fontSize: 110;
			foreground: (Color blue alpha: 0.5);
			yourself.

	(aText from: 1 to: 1)
		border: (BlBorder paint: Color red width: 8)
		above: false.

	(aText from: 2 to: 2)
		border: (BlBorder paint: Color red width: 8)
		above: true.

	(builder addTextToRoot: aText) padding: (BlInsets all: 10)
]

{ #category : #fixtures }
BlSpaceFixture >> buildTextWithDashedBorder [
	"Each character has a different dashes on its attribute."

	| aText |
	builder spaceExtent: 90 @ 100.

	aText := 'iii' asRopedText
		fontSize: 110;
		foreground: (Color yellow alpha: 0.5);
		yourself.

	(aText from: 1 to: 1)
		border: (BlBorder builder
			paint: Color blue;
			width: 6;
			dashArray: #(0 7);
			dashOffset: 1;
			capSquare;
			joinBevel;
			build).

	(aText from: 2 to: 2)
		border: (BlBorder builder
			paint: Color blue;
			width: 6;
			dashArray: #(1 1);
			dashOffset: 1;
			capButt;
			joinMiter;
			miterLimit: 1.5;
			build).

	(aText from: 3 to: 3)
		border: (BlBorder builder
			paint: Color blue;
			width: 6;
			dashArray: #(0 7);
			dashOffset: 1;
			capRound;
			joinRound;
			build).

	(builder addTextToRoot: aText)
		padding: (BlInsets all: 10)

]

{ #category : #fixtures }
BlSpaceFixture >> buildTextWithOverlappingBorder [
	"First subrope 'Bloc' is rendered behind the border of the second subrope."

	| aText |
	builder spaceExtent: 80 @ 25.

	aText := 'BlocBloc' asRopedText.
	aText fontSize: 15.
	aText foreground: Color blue.

	(aText from: 1 to: 4)
		border: (BlBorder
			paint: Color red
			width: 10).
	(aText from: 5 to: 8)
		border: (BlBorder
			paint: Color green
			width: 10).

	(builder addTextToRoot: aText)
		padding: (BlInsets all: 5)
]

{ #category : #fixtures }
BlSpaceFixture >> buildTransformRotate [

	| elementA elementB elementC |

	elementA := builder addToRoot
		geometry: BlTriangleGeometry new;
		position: 0 asPoint;
		size: 25 asPoint;
		transformDo: [ :t | t rotateBy: -135 ];
		yourself.

	elementB := builder addToRoot
		geometry: BlRectangleGeometry new;
		position: 20 asPoint;
		size: 20 asPoint;
		transformDo: [ :t | t rotateBy: 45 ];
		yourself.
		
	elementC := (builder addTo: elementB)
		geometry: BlRectangleGeometry new;
		transformDo: [ :t | t rotateBy: 180 ];
		position: 5 asPoint;
		size: 10 asPoint;
		yourself
]

{ #category : #fixtures }
BlSpaceFixture >> buildTransformScale [

	| elementA elementB elementC |

	"Center is at 10@10"
	elementA := builder addToRoot
		geometry: BlCircleGeometry new;
		position: 0 asPoint;
		size: 20 asPoint;
		transformDo: [ :t | t scaleBy: 1/2 ];
		yourself.

	"Center is 25@25 (10/2 + 20)"
	elementB := builder addToRoot
		geometry: BlCircleGeometry new;
		position: 20 asPoint;
		size: 10 asPoint;
		transformDo: [ :t | t scaleBy: 2 ];
		yourself.

	"C is in the center of it's parent, as they have the same size."
	elementC := (builder addTo: elementB)
		geometry: BlCircleGeometry new;
		position: 0 asPoint;
		size: 10 asPoint;
		transformDo: [ :t | t scaleBy: 0.5 ];
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildTransformTranslate [

	| elementA elementB elementC |

	elementA := builder addToRoot
		geometry: BlRectangleGeometry new;
		transformDo: [ :t | t translateBy: 10 ];
		size: 10 asPoint;
		yourself.

	elementB := builder addToRoot
		geometry: BlRectangleGeometry new;
		transformDo: [ :t | t translateBy: 15 ];
		size: 10 asPoint;
		yourself.
		
	elementC := (builder addTo: elementB)
		geometry: BlRectangleGeometry new;
		transformDo: [ :t | t translateBy: 5 ];
		size: 5 asPoint;
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOf: aGeometryFactoryBlock [

	| outskirts positionGenerator addElementBlock |
	builder spaceExtent: 150@220.

	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 40
		columns: 3.
	addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
		builder addToRoot
			geometry: aGeometryFactoryBlock value;
			border: (BlBorder paint: borderColor width: 5);
			background: backgroundColor;
			outskirts: aBlOutskirt;
			position: positionGenerator next;
			size: 35 asPoint;
			yourself ].
	
	"All Opaque"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor
			value: builder nextColor
			value: eachOutskirt ].

	"Opaques + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor
			value: builder nextColor translucent
			value: eachOutskirt ].

	"Translucents + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: builder nextColor translucent
			value: builder nextColor translucent
			value: eachOutskirt ].

	"Transparents + translucent border"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: Color transparent
			value: builder nextColor translucent
			value: eachOutskirt ].

	"Transformations"
	{	[ :t |
			t scaleBy: 0.8.
			"rotation at bottom-left:"
			t normalizedOrigin: 0 @ 1.
			t skewY: 10.
			t rotateBy: 5 ].
		[ :t |
			"rotation beyond top-right:"
			t normalizedOrigin: 0.5 @ -0.5.
			t rotateBy: -45.
			t scaleBy: 1.25. ].
		[ :t |
			t translateBy: 5 asPoint.
			t skewX: 10 ] 
	} do: [ :each |
		(addElementBlock
			value: builder nextColor translucent
			value: builder nextColor
			value: BlOutskirts inside)
				transformDo: each ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfAll: aBlElementGeometryCollection [

	| positionGenerator |
	builder spaceExtent: 150@210.

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 40
		columns: 3.
	
	aBlElementGeometryCollection do: [ :each |
		builder addToRoot
			geometry: each;
			border: (BlBorder paint: builder nextColor width: 2);
			background: builder nextColor;
			position: positionGenerator next;
			size: 30 asPoint;
			yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfAnnulusSector [

	self buildVariantsOf: 
		[BlAnnulusSectorGeometry new
			startAngle: 225;
			endAngle: 360;
			innerRadius: 0.3;
			outerRadius: 0.9]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfAnnulusSectorAngles [

	| positionGenerator addElementBlock addAnnulusVariationsForAnglesBlock pixelSize numberOfColumns |
	pixelSize := 20.
	numberOfColumns := "20" 5.
	builder spaceExtent: ((pixelSize*numberOfColumns) @ (pixelSize*3)) + 10 asPoint "margin".

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 5 asPoint
		by: pixelSize
		columns: numberOfColumns.

	addElementBlock := [ :anAngle :anotherAngle :innerRadius :outerRadius |
		builder addToRoot
			geometry: (BlAnnulusSectorGeometry new
				startAngle: anAngle;
				endAngle: anotherAngle;
				innerRadius: innerRadius;
				outerRadius: outerRadius);
			position: positionGenerator next;
			background: Color black;
			size: pixelSize asPoint;
			yourself ].

	addAnnulusVariationsForAnglesBlock := [ :anAngle :anotherAngle |
"		addElementBlock
			value: anAngle
			value: anotherAngle
			value: 0.0
			value: 1.0."
		addElementBlock
			value: anAngle
			value: anotherAngle
			value: 0.75
			value: 1.0.
"		addElementBlock
			value: anAngle
			value: anotherAngle
			value: 0.0
			value: 0.75.
		addElementBlock
			value: anAngle
			value: anotherAngle
			value: 0.3
			value: 0.7" ].

	#(
		0   270
		0   60
		270 45
	) pairsDo: [ :anAngle :anotherAngle |
		addAnnulusVariationsForAnglesBlock
			value: anAngle
			value: anotherAngle.
		addAnnulusVariationsForAnglesBlock
			value: anAngle + 45
			value: anotherAngle + 45.
		addAnnulusVariationsForAnglesBlock
			value: anAngle + 90
			value: anotherAngle + 90.
		addAnnulusVariationsForAnglesBlock
			value: anotherAngle
			value: anAngle.
		addAnnulusVariationsForAnglesBlock
			value: anotherAngle + 45
			value: anAngle + 45 ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfAnnulusSectorStartGreaterThanEnd [

	self buildVariantsOf: 
		[BlAnnulusSectorGeometry new
			startAngle: 180;
			endAngle: 90;
			innerRadius: 0.4;
			outerRadius: 1.0]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfBezier2CPs [

	self buildVariantsOfLinelikeGeometry:
		(BlBezierCurveGeometry controlPoints: {5 @ 0. 35 @ 40})
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfBezier3CPs [

	self buildVariantsOfLinelikeGeometry:
		(BlBezierCurveGeometry controlPoints: { 5@0. 20@35. 35@40 })
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfBezier4CPs [

	self buildVariantsOfLinelikeGeometry:
		(BlBezierCurveGeometry controlPoints: { 5@0. 15@30. 25@10. 35@40 })
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfCircleSector [

	self buildVariantsOf: 
		[BlAnnulusSectorGeometry new
			startAngle: 225;
			endAngle: 360;
			innerRadius: 0.0;
			outerRadius: 0.9]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfCircleSectorAngles [

	| positionGenerator addElementBlock addAnnulusVariationsForAnglesBlock pixelSize numberOfColumns angles |
	pixelSize := 20.
	numberOfColumns := 5.
	angles := #(
		0   270
		0   45
		270 540 "540 % 360 = 180"
	).
	builder spaceExtent: ((pixelSize*numberOfColumns) @ (pixelSize * (angles size / 2))) 
		+ 10 asPoint "margin".

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 5 asPoint
		by: pixelSize
		columns: numberOfColumns.

	addElementBlock := [ :anAngle :anotherAngle :innerRadius :outerRadius |
		builder addToRoot
			geometry: (BlAnnulusSectorGeometry new
				startAngle: anAngle;
				endAngle: anotherAngle;
				innerRadius: innerRadius;
				outerRadius: outerRadius);
			position: positionGenerator next;
			background: Color black;
			size: pixelSize asPoint;
			yourself ].

	addAnnulusVariationsForAnglesBlock := [ :anAngle :anotherAngle |
		addElementBlock
			value: anAngle
			value: anotherAngle
			value: 0.0
			value: 1.0 ].

	angles pairsDo: [ :anAngle :anotherAngle |
		addAnnulusVariationsForAnglesBlock
			value: anAngle
			value: anotherAngle.
		addAnnulusVariationsForAnglesBlock
			value: anAngle + 45
			value: anotherAngle + 45.
		addAnnulusVariationsForAnglesBlock
			value: anAngle + 90
			value: anotherAngle + 90.
		addAnnulusVariationsForAnglesBlock
			value: anotherAngle
			value: anAngle.
		addAnnulusVariationsForAnglesBlock
			value: anotherAngle + 45
			value: anAngle + 45 ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfCircleSectorAnglesCustomizedWith: aBlock [

	self buildVariantsOfCircleSectorAngles.

	builder space root allChildrenDepthFirstDo: aBlock
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfEllipse [

	| positionGenerator |
	builder spaceExtent: 170@70.

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 50
		columns: 3.
	
	{
		50 @ 30.
		30 @ 50.
		50 @ 50.
	} do: [ :each |
		builder addToRoot
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: builder nextColor translucent width: 10);
			background: builder nextColor translucent;
			position: positionGenerator next;
			size: each;
			outskirts: BlOutskirts outside;
			yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfHistogram [

	self buildVariantsOf: [
		BlHistogramGeometry values: (0 to: 1 by: 0.2) ]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfLine [

	self buildVariantsOfLinelikeGeometry:
		(BlLineGeometry from: 5 @ 0 to: 35 @ 40)
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfLinelikeGeometry: aGeometry [

	{	[ :t |
			t topLeftOrigin.
			t scaleBy: 2 ].
		[ :t |
			t translateBy: 0@100.
			t scaleBy: 0.4.
			"rotation at bottom-left:"
			t normalizedOrigin: 0@1.
			t skewY: 10.
			t rotateBy: 5 ].
		[ :t |
			"rotation beyond top-right:"
			t normalizedOrigin: 0.5 @ -0.1.
			t rotateBy: -45.
			t scaleBy: 1.25. ].
		[ :t |
			t translateBy: 15 asPoint.
			t skewX: 10 ] 
	} do: [ :each |
		builder addToRoot
			geometry: aGeometry;
			outskirts: BlOutskirts centered;
			border: (BlBorder paint: builder nextColor width: 10);
			position: 10 asPoint;
			transformDo: each;
			yourself ].
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfOutskirtCustomizedWith: aBlock [

	| outskirts borderWidth scale positionGenerator addElementBlock |
	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	borderWidth := 9.
	scale := 0.3.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 3 asPoint
		by: 32
		columns: 3.

	addElementBlock := [ :eachOutskirt :backgroundColor |
		builder addHexagonalPolygon
			position: positionGenerator next;
			background: backgroundColor;
			border: (BlBorder paint: builder nextColor width: borderWidth);
			outskirts: eachOutskirt;
			transformDo: [ :t | t topLeftOrigin; scaleBy: scale ];
			in: aBlock;
			yourself ].
	
	"Opaques"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: eachOutskirt
			value: builder nextColor ].

	"Translucents"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: eachOutskirt
			value: builder nextColor translucent ].

	"Transparents"
	outskirts do: [ :eachOutskirt |
		addElementBlock
			value: eachOutskirt
			value: Color transparent ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfPolygon [

	self buildVariantsOf: [BlPolygonGeometry vertices: self hexagonVertices]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfPolyline [

	self buildVariantsOf: [BlPolylineGeometry vertices: self hexagonVertices]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfRectangle [

	self buildVariantsOf: [BlRectangleGeometry new]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfRoundedRectangle [

	self buildVariantsOfAll: {
		(BlRoundedRectangleGeometry cornerRadius: 0).
		(BlRoundedRectangleGeometry cornerRadius: 10).
		(BlRoundedRectangleGeometry cornerRadius: 30).

		"individual corners"
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 15;
				topRight: 0;
				bottomLeft: 0;
				bottomRight: 0;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 15;
				bottomLeft: 0;
				bottomRight: 0;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 0;
				bottomLeft: 0;
				bottomRight: 15;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 0;
				bottomLeft: 15;
				bottomRight: 0;
				yourself)).

		"diagonals"
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 15;
				topRight: 0;
				bottomLeft: 0;
				bottomRight: 15;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 15;
				bottomLeft: 15;
				bottomRight: 0;
				yourself)).

		"in pairs"
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 15;
				topRight: 15;
				bottomLeft: 0;
				bottomRight: 0;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 15;
				bottomLeft: 0;
				bottomRight: 15;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 0;
				bottomLeft: 15;
				bottomRight: 15;
				yourself)).
		(BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 15;
				topRight: 0;
				bottomLeft: 15;
				bottomRight: 0;
				yourself)).
		}
	
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfRoundedRectangleAndOutskirts [

	self buildVariantsOf:
		[BlRoundedRectangleGeometry cornerRadii:
			(BlCornerRadii new
				topLeft: 0;
				topRight: 5;
				bottomLeft: 10;
				bottomRight: 25;
				yourself)]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfSigmoid [

	| positionGenerator |
	builder spaceExtent: 170@70.

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 50
		columns: 3.
	
	{
		50 @ 30.
		30 @ 50.
		50 @ 50.
	} do: [ :each |
		builder addToRoot
			geometry: (BlSigmoidGeometry from: 0@0 to: each);
			border: (BlBorder paint: builder nextColor width: 10);
			position: positionGenerator next;
			size: each;
			beOutskirtsCentered;
			yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfSquare [

	self buildVariantsOf: [BlSquareGeometry new]
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfStadium [

	| positionGenerator |
	builder spaceExtent: 170@70.

	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 50
		columns: 3.
	
	{
		50 @ 30.
		30 @ 50.
		50 @ 50.
	} do: [ :each |
		builder addToRoot
			geometry: BlStadiumGeometry new;
			border: (BlBorder paint: builder nextColor width: 5);
			background: builder nextColor;
			position: positionGenerator next;
			size: each;
			beOutskirtsCentered;
			yourself ].

]

{ #category : #private }
BlSpaceFixture >> diagonalPositionGeneratorStartingAt: aPoint by: by [
	
	^ Generator on: [ :g | 
		| index |
		index := 0.
		[ 	g yield: aPoint + index asPoint.
			index := index + by ] repeat ]
]

{ #category : #private }
BlSpaceFixture >> gridPositionGeneratorStartingAt: offset by: by columns: numberOfColumns [
	
	^ Generator on: [ :g | 
		| column next |
		column := 0.
		next := offset.
		
		[	[	"Put next position"
				g yield: next.

				"Advance to next column in same row"
				next := next + (by @ 0).
				column := column + 1.

			] doWhileTrue: [ column < numberOfColumns ].

			"Start a new row"
			next := offset x @ (next y + by).
			column := 0 

		] repeat ]
]

{ #category : #fixtures }
BlSpaceFixture >> hexagonVertices [

	^ {	 30 @  0.
		 10 @  0.
		  0 @ 18.
		 10 @ 35.
		 30 @ 35.
		 40 @ 18 }

]

{ #category : #accessing }
BlSpaceFixture >> host: aHost [
	
	builder host: aHost

]

{ #category : #initialization }
BlSpaceFixture >> initialize [

	super initialize.
	
	builder := BlSpaceBuilder new.

]

{ #category : #private }
BlSpaceFixture >> monospacedFontFamilyName [
		
	^ 'Source Code Pro'
]

{ #category : #private }
BlSpaceFixture >> ropedTextFor: aString [

	^ aString asRopedText
		  fontName: self sansFontFamilyName;
		  yourself
]

{ #category : #private }
BlSpaceFixture >> sansFontFamilyName [

	^ 'Source Sans Pro'
]

{ #category : #accessing }
BlSpaceFixture >> space [

	^ builder buildSpace; space	
]

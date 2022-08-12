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

	^ self allSelectors select: [ :each | 
		  (each beginsWith: #build) and: each isUnary ]
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
			relocate: positionGenerator next;
			size: 35 asPoint;
			yourself.
		child := (builder addTo: element)
			size: 20 asPoint;
			relocate: -2 asPoint;
			border: (BlBorder paint: Color yellow width: 1);
			yourself.
		(builder addTo: child)
			size: 20 asPoint;
			relocate: 10 asPoint;
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
		relocate: 10 asPoint;
		size: 10 asPoint;
		clipChildren: false;
		yourself.

	elementB := (builder addTo: elementA)
		geometry: BlRectangleGeometry new;
		relocate: 5 asPoint;
		size: 10 asPoint;
		clipChildren: true;
		yourself.
		
	elementC := (builder addTo: elementB)
		geometry: BlRectangleGeometry new;
		relocate: 5 asPoint;
		size: 10 asPoint;
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildElevation [

	| elementA elementB elementC childD childE childF |

	"A and children are on top"
	elementA := builder addCircle
		elevation: (BlRelativeElevation elevation: 101);
		relocate: 10@10;
		clipChildren: false;
		yourself.

	"B is below A"
	elementB := builder addCircle
		elevation: (BlGlobalElevation elevation: 90);
		relocate: 25@10;
		yourself.

	"C is below A"
	elementC := builder addCircle
		elevation: (BlGlobalElevation elevation: 100);
		relocate: 50@10;
		yourself.


	"D is below E, since 'relative' means relative to 0. 
	--> Bug? If it would be relative to its parent, it would
	be 101+5 => D would overlap E"
	childD := (builder addTo: elementA)
		elevation: (BlRelativeElevation elevation: 5);
		relocate: 10 @ 10;
		size: 30 asPoint;
		yourself.

	"Large elevation of a child doesn't mean it will overlap other
	elements than siblings"
	childE := (builder addTo: elementA)
		elevation: (BlGlobalElevation elevation: 102);
		relocate: 20 @ 20;
		size: 30 asPoint;
		yourself.

	"F goes below all siblings"
	childF := (builder addTo: elementA)
		elevation: (BlRelativeElevation elevation: -10);
		relocate: 30 @ 30;
		size: 30 asPoint;
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildImagesAndTransformations [
	
	| outskirts positionGenerator addElementBlock |

	builder spaceExtent: 120@350.

	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 5 asPoint
		by: 26
		columns: 4.
	addElementBlock := [ | aForm |
		aForm := Smalltalk ui icons iconNamed: #warning.
		builder addCircle
			background: aForm;
			relocate: positionGenerator next;
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
BlSpaceFixture >> buildOpacities [

	| size fillColor borderColor |
	size := 50 asPoint.
	fillColor := builder nextColor.
	borderColor := builder nextColor.
	
	builder addToRoot
		background: ((BlPaintBackground paint: fillColor asBlPaint) opacity: 0.75; yourself);
		opacity: 0.5;
		relocate: 10 @ 10;
		size: size;
		yourself.

	builder addToRoot
		background: ((BlPaintBackground paint: fillColor) opacity: 0.5; yourself);
		opacity: 0.75;
		relocate: 40 @ 10;
		size: size;
		yourself.

	builder addToRoot
		background: fillColor;
		border: (BlBorder builder
			paint: (borderColor alpha: 0.75) asBlPaint;
			width: 10;
			opacity: 0.5;
			build);
		relocate: 10 @ 40;
		size: size;
		yourself.

	builder addToRoot
		background: fillColor;
		border: (BlBorder builder
			paint: (borderColor alpha: 0.5) asBlPaint;
			width: 10;
			opacity: 0.75;
			build);
		relocate: 40 @ 40;
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
			relocate: positionGenerator next;
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
			relocate: positionGenerator next;
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
		gridPositionGeneratorStartingAt: 0 asPoint
		by: 20
		columns: 3.

	"Opaques"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				relocate: positionGenerator next;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t scaleBy: scale ];
				yourself ].

	"Translucents"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				relocate: positionGenerator next;
				background: builder nextColor translucent;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t scaleBy: scale ];
				yourself ].

	"Transparents"
	outskirts do: [ :eachOutskirt |
			builder addHexagonalPolygon
				relocate: positionGenerator next;
				background: Color transparent;
				border: (BlBorder paint: builder nextColor width: width);
				outskirts: eachOutskirt;
				transformDo: [ :t | t scaleBy: scale ];
				yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingCircles [

	| elementA elementB |

	elementA := builder addCircle
		relocate: 10 asPoint;
		size: 10 asPoint;
		yourself.

	elementB := builder addCircle
		relocate: 15 asPoint;
		size: 10 asPoint;
		yourself.

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingRectangles [
	"Note: This code assumes that default geometry is a rectangle."

	builder addToRoot
		relocate: 10 asPoint;
		size: 10 asPoint.

	builder addToRoot
		relocate: 15 asPoint;
		size: 10 asPoint.

]

{ #category : #fixtures }
BlSpaceFixture >> buildOverlappingTriangles [

	| elementA elementB |

	elementA := builder addToRoot
		geometry: BlTriangleGeometry new;
		relocate: 10 asPoint;
		size: 10 asPoint;
		yourself.

	elementB := builder addToRoot
		geometry: BlTriangleGeometry new;
		relocate: 15 asPoint;
		size: 10 asPoint;
		yourself

]

{ #category : #fixtures }
BlSpaceFixture >> buildStrokeStyles [

	| positionGenerator width |
	width := 9.
	positionGenerator := self
		diagonalPositionGeneratorStartingAt: 7
		by: 14.

	builder addPolyline
		relocate: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capButt;
			joinRound;
			paint: builder nextColor;
			build).

	builder addPolyline
		relocate: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capSquare;
			joinBevel;
			paint: builder nextColor;
			build).

	builder addPolyline
		relocate: positionGenerator next;
		border: (BlBorder builder
			width: width;
			capRound;
			joinMiter;
			miterLimit: 10;
			paint: builder nextColor;
			build).

	builder addPolyline
		relocate: positionGenerator next;
		border: (BlBorder builder
			dashArray: #(0 5);
			capRound;
			joinRound;
			paint: builder nextColor;
			width: 4;
			build).

	builder addPolyline
		relocate: positionGenerator next;
		border: (BlBorder builder
			dashArray: #(3 5);
			dashOffset: 5;
			paint: builder nextColor;
			capSquare;
			joinBevel;
			width: 3;
			build).

	builder addPolyline
		relocate: positionGenerator next;
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

	| emojiString |
	self ensureEmojiFontFace.

	builder spaceExtent: 200 @ 80.

	emojiString := WideString streamContents: [ :stream |
		#(16r1F44D 16r1f642 16r1F525 ) do: [ :each |
			stream nextPut: (Unicode value: each) ]].

	builder
		addTextToRoot: (emojiString asRopedText
			fontName: self emojiFontFamilyName;
			fontSize: 50;
			yourself)

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
		relocate: 50 asPoint;
		transformDo: [ :t |
			t translateBy: 15 asPoint.
			t skewX: 45 ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildTransformRotate [

	| elementA elementB elementC |

	elementA := builder addToRoot
		geometry: BlTriangleGeometry new;
		relocate: 0 asPoint;
		size: 25 asPoint;
		transformDo: [ :t | t rotateBy: -135 ];
		yourself.

	elementB := builder addToRoot
		geometry: BlRectangleGeometry new;
		relocate: 20 asPoint;
		size: 20 asPoint;
		transformDo: [ :t | t rotateBy: 45 ];
		yourself.
		
	elementC := (builder addTo: elementB)
		geometry: BlRectangleGeometry new;
		transformDo: [ :t | t rotateBy: 180 ];
		relocate: 5 asPoint;
		size: 10 asPoint;
		yourself
]

{ #category : #fixtures }
BlSpaceFixture >> buildTransformScale [

	| elementA elementB elementC |

	"Center is at 10@10"
	elementA := builder addToRoot
		geometry: BlCircleGeometry new;
		relocate: 0 asPoint;
		size: 20 asPoint;
		transformDo: [ :t | t scaleBy: 1/2 ];
		yourself.

	"Center is 25@25 (10/2 + 20)"
	elementB := builder addToRoot
		geometry: BlCircleGeometry new;
		relocate: 20 asPoint;
		size: 10 asPoint;
		transformDo: [ :t | t scaleBy: 2 ];
		yourself.

	"C is in the center of it's parent, as they have the same size."
	elementC := (builder addTo: elementB)
		geometry: BlCircleGeometry new;
		relocate: 0 asPoint;
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
BlSpaceFixture >> buildVariantsOf: aBlElementGeometry [

	| outskirts positionGenerator addElementBlock |
	builder spaceExtent: 150@220.

	outskirts := { BlOutskirts inside. BlOutskirts centered. BlOutskirts outside }.
	positionGenerator := self 
		gridPositionGeneratorStartingAt: 10 asPoint
		by: 40
		columns: 3.
	addElementBlock := [ :backgroundColor :borderColor :aBlOutskirt |
		builder addToRoot
			geometry: aBlElementGeometry;
			border: (BlBorder paint: borderColor width: 5);
			background: backgroundColor;
			outskirts: aBlOutskirt;
			relocate: positionGenerator next;
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
			relocate: positionGenerator next;
			size: 30 asPoint;
			yourself ].

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
			relocate: positionGenerator next;
			size: each;
			outskirts: BlOutskirts outside;
			yourself ].

]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfPolygon [

	self buildVariantsOf: (BlPolygonGeometry vertices: self hexagonVertices)
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfPolyline [

	self buildVariantsOf: (BlPolylineGeometry vertices: self hexagonVertices)
]

{ #category : #fixtures }
BlSpaceFixture >> buildVariantsOfRectangle [

	self buildVariantsOf: BlRectangleGeometry new
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
BlSpaceFixture >> buildVariantsOfSquare [

	self buildVariantsOf: BlSquareGeometry new
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
BlSpaceFixture >> emojiFontFamilyName [

	^ AeNotoColorEmojiDownloadedFont new familyName
]

{ #category : #private }
BlSpaceFixture >> ensureEmojiFontFace [

	self flag: #todo. "TODO shouldn't touch global manager"
	"This ensures the emoji font in repo's tests directory is loaded."
	(AeFontManager globalInstance includesFamilyName: self emojiFontFamilyName) ifFalse: [
		AeNotoColorEmojiDownloadedFont new ensureDownloaded.
		AeFontManager globalInstance scanDirectory: AeFilesytemResources fontsDirectory ].
	

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

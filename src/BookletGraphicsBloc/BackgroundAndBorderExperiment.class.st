"
various example on background and border settings in Bloc
"
Class {
	#name : #BackgroundAndBorderExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
BackgroundAndBorderExperiment class >> TriangleColorDashedMulti [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color yellow;
		  border: (BlBorder builder
				   width: 5;
				   paint: (Color red alpha: 1);
				   dashOffset: 0;
				   dashArray: #( 6 4 2 );
				   joinBevel;
				   build);
		  size: 200 @ 200
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> box: element text: aText [

	| container elt1 elt2 text |
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	elt1 := BlElement new
		        layout: BlFrameLayout new;
		        constraintsDo: [ :c |
			        c horizontal fitContent.
			        c vertical fitContent ].

	element constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	elt1 addChild: element.


	elt2 := BlElement new
		        layout: BlFrameLayout new;
				padding: (BlInsets all:3);
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ].

	text := BlTextElement new
		        position: 5 @ 5;
		        text: (aText asRopedText attributes:
					         { (BlTextForegroundAttribute paint: Color black) });
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter.
			        c frame vertical alignCenter ].
	elt2 addChild: text.

	container addChildren: {
			elt1.
			elt2 }.
	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleElementOutskirts [

	<demo>
	<sampleInstance>
	| container |
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 5);
		             padding: (BlInsets all: 5);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 5);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].
	"size: 450 @ 150;"


	container addChild:
		(self box: self outskirtsOutside text: 'outskirts outside').
	container addChild:
		(self box: self outskirtsCentered text: 'outskirts centered').
	container addChild:
		(self box: self outskirtsInside text: 'outskirts inside').

	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleElementWithOpacity [
<demo>
	<sampleInstance>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightRed;
		        opacity: 0.1;
		        border: (BlBorder paint: Color red width: 5).
	element1 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlPolygonGeometry vertices: {
						             (50 @ 0).
						             (65 @ 40).
						             (100 @ 40).
						             (75 @ 60).
						             (85 @ 100).
						             (50 @ 80).
						             (15 @ 100).
						             (25 @ 60).
						             (0 @ 40).
						             (35 @ 40) });
		            border: (BlBorder paint: Color orange width: 5);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightYellow;
		        opacity: 0.5;
		        border: (BlBorder paint: Color yellow width: 5).
	element2 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlPolygonGeometry vertices: {
						             (50 @ 0).
						             (65 @ 40).
						             (100 @ 40).
						             (75 @ 60).
						             (85 @ 100).
						             (50 @ 80).
						             (15 @ 100).
						             (25 @ 60).
						             (0 @ 40).
						             (35 @ 40) });
		            border: (BlBorder paint: Color green width: 5);
		            background: Color lightGreen;
		            outskirts: BlOutskirts centered.

	box2 addChild: element2.

	box3 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightBlue;
		        opacity: 0.9;
		        border: (BlBorder paint: Color blue width: 5).
	element3 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlPolygonGeometry vertices: {
						             (50 @ 0).
						             (65 @ 40).
						             (100 @ 40).
						             (75 @ 60).
						             (85 @ 100).
						             (50 @ 80).
						             (15 @ 100).
						             (25 @ 60).
						             (0 @ 40).
						             (35 @ 40) });
		            border: (BlBorder paint: Color cyan width: 5);
		            background: Color lightCyan;
		            outskirts: BlOutskirts centered.

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleTriangle [

	<demo>
	<sampleInstance>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightRed;
		        border: (BlBorder paint: Color red width: 5).
	element1 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		            border: (BlBorder builder
				             paint: Color orange;
				             width: 15;
				             build);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightYellow;
		        border: (BlBorder paint: Color yellow width: 5).
	element2 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		            border: (BlBorder builder
				             paint: Color green;
				             width: 15;
				             build);
		            background: Color lightGreen;
		            outskirts: BlOutskirts centered.

	box2 addChild: element2.

	box3 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightBlue;
		        border: (BlBorder paint: Color blue width: 5).
	element3 := BlElement new
		            size: 100 @ 100;
		            geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		            border: (BlBorder builder
				             paint: Color cyan;
				             width: 15;
				             build);
		            background: Color lightCyan;
		            outskirts: BlOutskirts centered.

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleTriangleBackground [

	<demo>
	<sampleInstance>
	| container |
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: (self
			 box: self triangleBackgroundImage
			 text: 'image').
	container addChild: (self
			 box: self triangleBackgroundSolidColor
			 text: 'solid color').
	container addChild: (self
			 box: self triangleBackgroundLinearColor
			 text: 'linear color').
	container addChild: (self
			 box: self triangleBackgroundRadialColor
			 text: 'radial color').

	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleTriangleBorderColor [

	<demo>
	<sampleInstance>
	| container |
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: (self
			 box: self triangleBorderSolidColor
			 text: 'solid color').
	container addChild: (self
			 box: self triangleBorderLinearGradient
			 text: 'linear color').
	container addChild: (self
			 box: self triangleBorderRadialGradient
			 text: 'radial color').

	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleTriangleDashed [

	<demo>
	<sampleInstance>
	| container |
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: (self
			 box: self triangleDashedSmall
			 text: 'dashedSmall').
	container addChild: (self
			 box: self triangleDashedArray
			 text: 'dashOffset: 0; dashArray: #( 6 4 2 )').
	container addChild: (self
			 box: self triangleDashedNormal
			 text: 'dashed').

	^ container
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> multipleTriangleWithCapAndJoin [

	<demo>
	<sampleInstance>
	| container |
	container := BlElement new
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: (self
			 box: self triangleJoinRound
			 text: 'round join').
	container addChild: (self
			 box: self triangleJoinBevel
			 text: 'bevel join').
	container addChild: (self
			 box: self triangleJoinMiter
			 text: 'miter join').

	^ container
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> outskirtsCentered [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightYellow;
		       border: (BlBorder paint: Color yellow width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlPolygonGeometry vertices: {
						            (50 @ 0).
						            (65 @ 40).
						            (100 @ 40).
						            (75 @ 60).
						            (85 @ 100).
						            (50 @ 80).
						            (15 @ 100).
						            (25 @ 60).
						            (0 @ 40).
						            (35 @ 40) });
		           border: (BlBorder paint: Color green width: 10);
		           background: Color lightGreen;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> outskirtsInside [
|box element|
box := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;

		         background: Color lightBlue;
		        border: (BlBorder paint: Color blue width: 5).
	element := BlElement new
		            size: 100 @ 100;
		            geometry: (BlPolygonGeometry vertices: {
						              (50 @ 0).
						              (65 @ 40).
						              (100 @ 40).
						              (75 @ 60).
						              (85 @ 100).
						              (50 @ 80).
						              (15 @ 100).
						              (25 @ 60).
						              (0 @ 40).
						              (35 @ 40) });
		            border: (BlBorder paint: Color cyan width: 10);
		            background: Color lightCyan;
		            outskirts: BlOutskirts inside.

	box addChild: element.
	^box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> outskirtsOutside [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightRed;
		       border: (BlBorder paint: Color red width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlPolygonGeometry vertices: {
						            (50 @ 0).
						            (65 @ 40).
						            (100 @ 40).
						            (75 @ 60).
						            (85 @ 100).
						            (50 @ 80).
						            (15 @ 100).
						            (25 @ 60).
						            (0 @ 40).
						            (35 @ 40) });
		           border: (BlBorder paint: Color orange width: 10);
		           background: Color lightOrange;
		           outskirts: BlOutskirts outside.

	box addChild: element.
	^ box
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBackgroundImage [
	"not working currently"
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background:
		  (BlImageBackground image: PolymorphSystemSettings pharoLogoForm);
		  border: (BlBorder paint: Color lightGray width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBackgroundLinearColor [
	"not working currently"
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: ((BlLinearGradientPaint direction: 1 @ 1)
				   from: Color red
				   to: Color blue);
		  border: (BlBorder paint: Color lightGray width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBackgroundRadialColor [
	"not working currently"
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: (BlRadialGradientPaint new
				   stops: {
						   (0 -> Color blue).
						   (1 -> Color red) };
				   center: 75 @ 75;
				   radius: 50;
				   yourself);
		  border: (BlBorder paint: Color lightGray width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBackgroundSolidColor [
	"not working currently"
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: (Color
				   r: 63
				   g: 81
				   b: 181
				   range: 255);
		  border: (BlBorder paint: Color lightGray width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBorderImage [
	"not working currently"
	
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color lightGray;
		  border: (BlBorder
				   paint:
				   (BlImagePatternPaint form:
					    PolymorphSystemSettings pharoLogoForm)
				   width: 50);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBorderLinearGradient [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color lightGray;
		  border: (BlBorder
				   paint: ((BlLinearGradientPaint direction: 1 @ 1)
						    matchExtent: 100 @ 75;
						    from: Color blue to: Color red)
				   width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBorderRadialGradient [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color lightGray;
		  border: (BlBorder
				   paint: (BlRadialGradientPaint new
						    stops: {
								    (0 -> Color blue).
								    (1 -> Color red) };
						    center: 50 @ 100 // 2;
						    radius: 50;
						    yourself)
				   width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleBorderSolidColor [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color lightGray;
		  border: (BlBorder paint: Color red width: 10);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleColorDashed [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color yellow;
		  border: (BlBorder builder
				   width: 5;
				   paint: (Color red alpha: 1);
				   dashOffset: 0;
				   dashArray: #( 6 4 2 );
				   joinBevel;
				   build);
		  size: 200 @ 200
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleDashedArray [

	| box element |
	box := BlElement new
		       size: 250 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightYellow;
		       border: (BlBorder paint: Color yellow width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color green;
				            width: 15;
				            dashOffset: 0;
				            dashArray: #( 6 4 2 );
				            capButt;
				            build);
		           background: Color lightGreen;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleDashedColorWithBuilder [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color yellow;
		  border: (BlBorder builder
				   width: 5;
				   paint: (Color red alpha: 0.5);
				   dashed;
				   build);
		  size: 100 @ 100
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleDashedNormal [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightBlue;
		       border: (BlBorder paint: Color blue width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color cyan;
				            width: 15;
				            dashed;
				            joinRound;
				            build);
		           background: Color lightCyan;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleDashedSmall [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightRed;
		       border: (BlBorder paint: Color red width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color orange;
				            width: 15;
				            dashedSmall;
				            joinRound;
				            build);
		           background: Color lightOrange;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleJoinBevel [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightYellow;
		       border: (BlBorder paint: Color yellow width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color green;
				            width: 15;
				            capButt;
				            joinBevel;
				            build);
		           background: Color lightGreen;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleJoinMiter [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightBlue;
		       border: (BlBorder paint: Color blue width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color cyan;
				            width: 15;
				            capSquare;
				            joinMiter;
				            build);
		           background: Color lightCyan;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #'examples - helpers' }
BackgroundAndBorderExperiment class >> triangleJoinRound [

	| box element |
	box := BlElement new
		       size: 150 @ 150;
		       geometry: BlRectangleGeometry new;
		       margin: (BlInsets all: 3);
		       padding: (BlInsets all: 3);
		       layout: BlLinearLayout horizontal alignCenter;
		       background: Color lightRed;
		       border: (BlBorder paint: Color red width: 5).
	element := BlElement new
		           size: 100 @ 100;
		           geometry: (BlTriangleGeometry new matchExtent: 50 @ 100);
		           border: (BlBorder builder
				            paint: Color orange;
				            width: 15;
				            capRound;
				            joinRound;
				            build);
		           background: Color lightOrange;
		           outskirts: BlOutskirts centered.

	box addChild: element.
	^ box
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleSolidColor [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color yellow;
		  border: (BlBorder paint: Color red width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
BackgroundAndBorderExperiment class >> triangleSolidColorWithBuilder [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: Color yellow;
		  border: (BlBorder builder
				   width: 5;
				   paint: Color red;
				   build);
		  size: 100 @ 100
]

{ #category : #'see class side' }
BackgroundAndBorderExperiment >> seeClassSide [ 
]

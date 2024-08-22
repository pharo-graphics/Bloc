"
examples of geometry bonds and possibility within Bloc
"
Class {
	#name : #GeometryExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
GeometryExperiment class >> allGeometryExample [

	<demo>
	<sampleInstance>
	| space root elements  |
	space := BlSpace new.

	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFlowLayout horizontal;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical fitContent ].


	elements := Dictionary new.
	elements at: 'annulul' put: self annulus.
	elements at: 'bezier' put: self bezier.
	elements at: 'circle' put: self circle.
	elements at: 'ellipse' put: self ellipse.
	elements at: 'line' put: self line.
	elements at: 'polygon' put: self polygon.
	elements at: 'polyline' put: self polyline.
	elements at: 'rectangle' put: self rectangle.
	elements
		at: 'rounded rectangle'
		put: self roundedRectangle.
	elements at: 'square' put: self square.
	elements at: 'triangle' put: self triangle.
	elements keysAndValuesDo: [ :key :value |
		root addChild: (self box: value text: key) ].


	^ root
]

{ #category : #examples }
GeometryExperiment class >> annulus [
	<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlAnnulusSectorGeometry new
				   startAngle: 225;
				   endAngle: 360;
				   innerRadius: 0.3;
				   outerRadius: 0.9);
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #'examples - helpers' }
GeometryExperiment class >> background [

	^ Color yellow
]

{ #category : #examples }
GeometryExperiment class >> basicBorder [

	<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: self background;
		  border: (BlBorder paint: Color red width: 5);
		  size: 100 @ 100
]

{ #category : #examples }
GeometryExperiment class >> bezier [

	<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlBezierCurveGeometry controlPoints: {
						   (5 @ 0).
						   (25 @ 80).
						   (75 @ 30).
						   (95 @ 100) });
		  size: 100 @ 100;
		  background: self background;
		  outskirts: BlOutskirts centered;
		  border: self border
]

{ #category : #'examples - helpers' }
GeometryExperiment class >> border [

	^ BlBorder paint: Color red width: 5
]

{ #category : #'examples - helpers' }
GeometryExperiment class >> box: element text: aText [
|container elt1 elt2 text|

container := BlElement new
				border: (BlBorder paint: Color blue width: 1);
		        background: (Color blue alpha: 0.2);
		        layout: BlLinearLayout vertical ;
				  constraintsDo: [ :c |
			           c horizontal fitContent.
			           c vertical fitContent  ].
		
		elt1 := BlElement new
 					size: 110 @ 110;
			       background: (Color orange alpha: 0.2);
			       border: (BlBorder paint: Color orange width: 1);
			       layout: BlFrameLayout new.
			
		element  constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter. ].

		elt1 addChild: element.
		
		
		elt2 := BlElement new
 					size: 110 @ 25;
			       background: (Color orange alpha: 0.2);
			       border: (BlBorder paint: Color orange width: 1);
			       layout: BlFrameLayout new.
			
		text := BlTextElement new
				      position: 5 @ 5;
				      text: (aText asRopedText attributes: { (BlTextForegroundAttribute paint: Color black)});
				constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter. ].
		elt2 addChild: text.

container addChildren: { elt1 . elt2 }.
^ container.
]

{ #category : #examples }
GeometryExperiment class >> builderBorder [

	<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: self background;
		  border: (BlBorder builder
				   paint: Color red;
				   width: 5;
				   build);
		  size: 100 @ 100
]

{ #category : #examples }
GeometryExperiment class >> builderCapButtBorder [

<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 100 @ 200;
				   beLeft);
		  background: self background;
		  border: (BlBorder builder
				   paint: Color red;
				   width: 5;
				   lineCap: BlStrokeLineCap butt;
				   lineJoin: BlStrokeLineJoin bevel;
				   miterLimit: 2.0;
				   dashArray: #( 10 5 );
				   dashOffset: 0;
				   build);
		  size: 200 @ 200
]

{ #category : #examples }
GeometryExperiment class >> builderOpacityBorder [

<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: self background;
		  border: (BlBorder builder
				   paint: Color red;
				   width: 5;
				   opacity: 0.1;
				   build);
		  size: 100 @ 100
]

{ #category : #examples }
GeometryExperiment class >> circle [

<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlCircleGeometry new matchExtent: 100 @ 50);
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> donutAnnulusGeometry [

	<demo>
	<sampleInstance>
	| elt |
	elt := BlElement new
		       size: 400 @ 400;
		       addChildren: ({
				        ((-90 to: 30) -> (Color
						          r: 111
						          g: 91
						          b: 149
						          range: 255)).
				        ((30 to: 60) -> (Color
						          r: 152
						          g: 138
						          b: 193
						          range: 255)).
				        ((60 to: 120) -> (Color
						          r: 237
						          g: 150
						          b: 54
						          range: 255)).
				        ((120 to: 150) -> (Color
						          r: 243
						          g: 189
						          b: 55
						          range: 255)).
				        ((150 to: 230) -> (Color
						          r: 36
						          g: 174
						          b: 226
						          range: 255)).
				        ((230 to: 270) -> (Color
						          r: 99
						          g: 197
						          b: 198
						          range: 255)) } collect: [ :each |
					        BlElement new
						        geometry: (BlAnnulusSectorGeometry new
								         startAngle: each key first;
								         endAngle: each key last);
						        background: each value;
						        constraintsDo: [ :c |
							        c horizontal matchParent.
							        c vertical matchParent ] ]).
	^ elt
]

{ #category : #examples }
GeometryExperiment class >> ellipse [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlEllipseGeometry new matchExtent: 100 @ 50);
		  size: 100 @ 50;
		  background: self background;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> line [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlLineGeometry from: 10 @ 10 to: 90 @ 90);
		  size: 100 @ 100;
		  background: self background;
		  outskirts: BlOutskirts centered;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> polygon [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlPolygonGeometry vertices: {
						   (10 @ 10).
						   (10 @ 90).
						   (50 @ 50).
						   (90 @ 90).
						   (90 @ 10) });
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> polyline [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlPolylineGeometry vertices: {
						   (10 @ 10).
						   (10 @ 90).
						   (50 @ 50).
						   (90 @ 90).
						   (90 @ 10) });
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> rectangle [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: BlRectangleGeometry new;
		  background: self background;
		  border: self border;
		  size: 100 @ 70
]

{ #category : #examples }
GeometryExperiment class >> roundedRectangle [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 20);
		  background: self background;
		  border: self border;
		  size: 100 @ 70
]

{ #category : #examples }
GeometryExperiment class >> square [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlSquareGeometry new matchExtent: 70 @ 70);
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #examples }
GeometryExperiment class >> triangle [
<demo>
	<sampleInstance>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				   matchExtent: 50 @ 100;
				   beLeft);
		  background: self background;
		  border: self border;
		  size: 100 @ 100
]

{ #category : #'see class side' }
GeometryExperiment >> seeClassSide [ 
]

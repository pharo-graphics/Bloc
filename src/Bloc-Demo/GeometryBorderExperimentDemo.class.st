Class {
	#name : #GeometryBorderExperimentDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'shapes - demo' }
GeometryBorderExperimentDemo >> TriangleColorDashedMulti [

	<bookExample>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		  background: Color yellow;
		  border: (BlBorder builder
				   width: 5;
				   paint: (Color red alpha: 1);
					dashOffset: 0;
				dashArray: #(6 4 2);
				   joinBevel  ;
				   build);
		  size: 200 @ 200
]

{ #category : #'as yet unclassified' }
GeometryBorderExperimentDemo >> multipleElementOutskirts [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 5);
		             padding: (BlInsets all: 5);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 5).
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

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #'as yet unclassified' }
GeometryBorderExperimentDemo >> multipleElementWithOpacity [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             opacity: 0.5;
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

{ #category : #'as yet unclassified' }
GeometryBorderExperimentDemo >> multipleTriangle [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 1350 @ 450;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 450 @ 450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color orange); width: 15; build);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 450 @450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color green); width: 15;  build);
		            background: Color lightGreen;
		            outskirts: BlOutskirts centered.

	box2 addChild: element2.
	
	box3 := BlElement new
		        size: 450 @ 450;
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
		            size: 300@300;
		           		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color cyan); width: 15; build);
		            background: Color lightCyan;
		            outskirts: BlOutskirts centered.

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #'as yet unclassified' }
GeometryBorderExperimentDemo >> multipleTriangleDashed [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 1350 @ 450;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 450 @ 450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color orange); width: 15; dashedSmall; joinRound; build );
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 450 @450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color green); width: 15; dashOffset: 0;
				dashArray: #(6 4 2); capButt  ;build);
		            background: Color lightGreen;
		            outskirts: BlOutskirts centered.

	box2 addChild: element2.
	
	box3 := BlElement new
		        size: 450 @ 450;
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
		            size: 300@300;
		           		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color cyan); width: 15; dashed; joinRound;build);
		            background: Color lightCyan;
		            outskirts: BlOutskirts centered.

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #'as yet unclassified' }
GeometryBorderExperimentDemo >> multipleTriangleWithCapAndJoin [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 1350 @ 450;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 450 @ 450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color orange); width: 15; capRound; joinRound; build);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 450 @450;
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
		            size: 300 @ 300;
		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color green); width: 15; capButt; joinBevel; build);
		            background: Color lightGreen;
		            outskirts: BlOutskirts centered.

	box2 addChild: element2.
	
	box3 := BlElement new
		        size: 450 @ 450;
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
		            size: 300@300;
		           		            geometry: (BlTriangleGeometry new
				   matchExtent: 150 @ 300);
		            border: (BlBorder  builder paint: (Color cyan); width: 15; capSquare; joinMiter; build);
		            background: Color lightCyan;
		            outskirts: BlOutskirts centered.

	box3 addChild: element3.
	container addChildren: {
			box1.
			box2.
			box3 }.
	^ container
]

{ #category : #'shapes - demo' }
GeometryBorderExperimentDemo >> triangleColorDashed [

	<bookExample>
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

{ #category : #'shapes - demo' }
GeometryBorderExperimentDemo >> triangleDashedColorWithBuilder [

	<bookExample>
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

{ #category : #'shapes - demo' }
GeometryBorderExperimentDemo >> triangleSolidColor [

	<bookExample>
	^BlElement new
		geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		background:  Color yellow;
		border: (BlBorder paint: Color red width: 5);
		size: 100 @ 100
]

{ #category : #'shapes - demo' }
GeometryBorderExperimentDemo >> triangleSolidColorWithBuilder [

	<bookExample>
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

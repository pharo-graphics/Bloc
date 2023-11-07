Class {
	#name : #RdvLayoutBlockDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> frameDrawingExample [
<gtExample>
^BlElement new
    layout: (BlGridLayout horizontal columnCount: 3);
    constraintsDo: [ :c |
        c horizontal matchParent.
        c vertical matchParent ];
    addChildren: {
        "top row"
        (BlTextElement new text: '5,0' asRopedText).
        (BlElement new size: 0@0).
        (BlTextElement new text: '13,0' asRopedText).
        
        "middle row"
        (BlElement new size: 0@0).
        (BlElement new
            constraintsDo: [ :c |
                c horizontal matchParent.
                c vertical matchParent ];
            border: (BlBorder paint: Color gray width: 1)).
        (BlElement new size: 0@0).
        
        "bottom row"
        (BlTextElement new text: '5,25' asRopedText).
        (BlElement new size: 0@0).
        (BlTextElement new text: '13,25' asRopedText). }
]

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> layout1 [
	"This is a new method"

	<bookExample>
	^ BlElement new
		  layout: BlLinearLayout horizontal;
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.2);
		  addChildren: {
				  (BlElement new
					   size: 100 @ 200;
					   background: (Color red alpha: 0.2)).
				  (BlElement new
					   size: 200 @ 100;
					   background: (Color blue alpha: 0.2)) }
]

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> layout2 [
	"This is a new method"

	<bookExample>
	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.2);
		  addChildren: {
				  (BlElement new
					   size: 100 @ 200;
					   background: (Color red alpha: 0.2)).
				  (BlElement new
					   size: 200 @ 100;
					   background: (Color blue alpha: 0.2)) }
]

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> layout3 [
	"This is a new method"

	<bookExample>
	^ BlElement new
		  layout: BlLinearLayout horizontal;
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.2);
		  addChildren: {
				  (BlElement new
					   size: 100 @ 200;
					   background: (Color red alpha: 0.2)).
				  (BlElement new
					   size: 200 @ 100;
					   background: (Color blue alpha: 0.2);
					   constraintsDo: [ :c |
						   c ignoreByLayout.
						   c vertical exact: 200.
						   c horizontal exact: 100.
						   c ignored horizontal alignRight.
						   c ignored vertical alignBottom ]) } "alignCenter"
]

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> layout4 [
	"This is a new method"

	<bookExample>
	^ BlElement new
		  layout: BlLinearLayout horizontal;
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.2);
		  addChildren: {
				  (BlElement new
					   size: 100 @ 200;
					   background: (Color red alpha: 0.2)).
				  (BlElement new
					   size: 200 @ 100;
					   background: (Color blue alpha: 0.2);
					   constraintsDo: [ :c |
						   c ignoreByLayout.
						   c vertical exact: 200.
						   c horizontal exact: 100.
						   c horizontal matchParent.
						   c ignored horizontal alignRight.
						   c ignored vertical alignBottom ]) } "alignCenter"
]

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> layout5 [
	"This is a new method"

	<bookExample>
	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.2);
		  addChildren: {
				  (BlElement new
					   size: 100 @ 200;
					   background: (Color red alpha: 0.2)).
				  (BlElement new
					   size: 200 @ 100;
					   background: (Color blue alpha: 0.2);
					   constraintsDo: [ :c | c margin: (BlInsets all: 10) ]) }
]

{ #category : #demo }
RdvLayoutBlockDemo >> multipleElement [

	<bookExample>
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
		            border: (BlBorder  paint: (Color orange) width: 5);
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

{ #category : #demo }
RdvLayoutBlockDemo >> multipleElement2 [

	<bookExample>
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
		        "layout: BlLinearLayout horizontal alignCenter ;"
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightRed;
		        border: (BlBorder paint: Color red width: 5).
	element1 := BlElement new
						size: 100@100;
						position: 50@50;
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
						geometryBounds: (BlBounds origin: 0@0 extent: 50@50 );
		            border: (BlBorder paint: Color orange width: 5);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

		box1 addChild: element1.
	"element1 position: 100@50; forceLayout."
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

{ #category : #demo }
RdvLayoutBlockDemo >> multipleElementAlignments [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal alignCenter;
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
						constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent  ];
		            border: (BlBorder paint: Color orange width: 5);
		            background: Color lightOrange;
		            outskirts: BlOutskirts centered.

	box1 addChild: element1.
	box2 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter  ;
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
		        layout: BlLinearLayout horizontal alignBottomLeft  ;
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

{ #category : #demo }
RdvLayoutBlockDemo >> multipleElementFitParameter [

	<bookExample>
	| element1 element2 element3 container box1 box2 box3 |
	container := BlElement new
		             size: 450 @ 150;
		             geometry: BlRectangleGeometry new;
		             margin: (BlInsets all: 3);
		             padding: (BlInsets all: 3);
		             layout: BlLinearLayout horizontal alignCenter ;
		             background: Color lightGray;
		             border: (BlBorder paint: Color black width: 3).
	box1 := BlElement new
		        size: 150 @ 150;
		        geometry: BlRectangleGeometry new;
		        margin: (BlInsets all: 3);
		        padding: (BlInsets all: 3);
		        layout: BlLinearLayout horizontal alignCenter;
		        constraintsDo: [ :c |
			        c horizontal fitContent   .
			        c vertical fitContent ];
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
			        c horizontal fitContent.
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
			        c vertical fitContent  ];
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

{ #category : #'accessing - demo' }
RdvLayoutBlockDemo >> squareSurroundedByNumbers [

	<bookExample>
	^ BlElement new
		  layout: (BlGridLayout horizontal columnCount: 3);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChildren: {
				  (BlTextElement new text: '5,0' asRopedText).
				  (BlElement new size: 0 @ 0).
				  (BlTextElement new text: '13,0' asRopedText).

				  "middle row"
				  (BlElement new size: 0 @ 0).
				  (BlElement new
					   constraintsDo: [ :c |
						   c horizontal matchParent.
						   c vertical matchParent ];
					   border: (BlBorder paint: Color gray width: 1)).
				  (BlElement new size: 0 @ 0).

				  "bottom row"
				  (BlTextElement new text: '5,25' asRopedText).
				  (BlElement new size: 0 @ 0).
				  (BlTextElement new text: '13,25' asRopedText) }
	"top row"
]

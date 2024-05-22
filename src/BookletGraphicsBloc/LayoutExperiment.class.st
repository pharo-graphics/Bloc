"
various demo of layout capabilities of Bloc
"
Class {
	#name : #LayoutExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
LayoutExperiment class >> basicLayoutExample [
<demo>
	<sampleInstance>
	| root elt1 elt2 |

	"BlBasicLayout let you position your children at the position you want them to be
	Layout constraint are irrelevant for this layout, you should specify the size of 
	each child element to be added. Those child can them implement their own layout strategy"
	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        "not necessary, except for reminder, this is the default layout""layout: BlBasicLayout new;"
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ].

	elt1 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        size: 40 @ 80;
		        background: (Color blue alpha: 0.2);
		        position: 50 @ 40.
	elt2 := BlElement new
		        border: (BlBorder paint: Color yellow width: 1);
		        size: 40 @ 80;
		        background: (Color yellow alpha: 0.2);
		        position: 60 @ 60.

	root addChildren: {
			elt1.
			elt2 }.

	^ root
]

{ #category : #examples }
LayoutExperiment class >> centerAndSize [
<demo>
	<sampleInstance>
	| centersAndSizes container |
	centersAndSizes := {
		                   {
			                   (50 @ 10).
			                   (100 @ 10) }.
		                   {
			                   (50 @ 10).
			                   (80 @ 15) } }.
	container := BlElement new
		             size: 200 @ 100;
		             yourself.
	centersAndSizes do: [ :c |
		container addChild: (BlElement new
				 background: (Color random alpha: 0.5);
				 position: c first - (c second / 2);
				 size: c second;
				 yourself) ].
	^ container
]

{ #category : #examples }
LayoutExperiment class >> flowLayoutExample [
<demo>
	<sampleInstance>
	| root |

	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFlowLayout horizontal;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical fitContent ].
	"Child need to specify their size. If they use constraint, the last one will hide previous one.
	They will fit available space + move to next line if necessary"

	50 timesRepeat: [
		| elt |
		elt := BlElement new
			       size: 40 @ 80;
			       border: (BlBorder paint: Color blue width: 1);
			       background: (Color blue alpha: 0.2);
			       margin: (BlInsets all: 5).
		root addChild: elt ].

	^ root
]

{ #category : #examples }
LayoutExperiment class >> frameLayoutExample [
<demo>
	<sampleInstance>
	| container child |
	"designed to block out an area on the screen to display a single child."

	container := BlElement new
		             background: (Color red alpha: 0.2);
		             border: (BlBorder paint: Color red width: 1);
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ].

	child := BlElement new
		         size: 30 @ 30;
		         clipChildren: false;
		         background: (Color blue alpha: 0.2);
		         border: (BlBorder paint: Color blue width: 1);
		         constraintsDo: [ :c |
			         c frame horizontal alignCenter.
			         c frame vertical alignBottom ].

	container addChild: child.

	^ container
]

{ #category : #examples }
LayoutExperiment class >> frameLayoutExample2 [
<demo>
	<sampleInstance>
	| root elt1 elt2 elt3 elt4 elt5 elt6 elt7 elt8 elt9 |
	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFrameLayout new;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ].

	"weight can only be used if the size, or if fitContent are not specified"
	elt1 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft weight: 0.2.
			        c frame vertical alignTop weight: 0.2.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild: (BlTextElement new text: 'left top' asRopedText).
	root addChild: elt1.

	elt2 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft weight: 0.33.
			        c frame vertical alignCenter weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'left center' asRopedText).
	root addChild: elt2.

	elt3 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft weight: 0.33.
			        c frame vertical alignBottom weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'left bottom' asRopedText).
	root addChild: elt3.

	elt4 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter weight: 0.33.
			        c frame vertical alignTop weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild: (BlTextElement new text: 'center top' asRopedText).
	root addChild: elt4.

	elt5 := BlElement new
		        size: 40 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter weight: 0.33.
			        c frame vertical alignCenter weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'center center' asRopedText).
	root addChild: elt5.

	elt6 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter weight: 0.33.
			        c frame vertical alignBottom weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'center bottom' asRopedText).
	root addChild: elt6.

	elt7 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight weight: 0.33.
			        c frame vertical alignTop weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild: (BlTextElement new text: 'right top' asRopedText).
	root addChild: elt7.

	elt8 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight weight: 0.33.
			        c frame vertical alignCenter weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'right center' asRopedText).
	root addChild: elt8.

	elt9 := BlElement new
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight weight: 0.33.
			        c frame vertical alignBottom weight: 0.33.
			        c horizontal matchParent.
			        c vertical matchParent ];
		        addChild:
			        (BlTextElement new text: 'right bottom' asRopedText).
	root addChild: elt9.

	^ root
]

{ #category : #examples }
LayoutExperiment class >> frameLayoutExample3 [
	"this could probably be achieved with grid layout as well."
<demo>
	<sampleInstance>
	| root elt1 elt2 elt3 elt4 elt5 elt6 elt7 elt8 elt9 |
	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFrameLayout new;
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ].

	elt1 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft.
			        c frame vertical alignTop ];
		        addChild: (BlTextElement new text: 'left top' asRopedText).
	root addChild: elt1.

	elt2 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft.
			        c frame vertical alignCenter ];
		        addChild:
			        (BlTextElement new text: 'left center' asRopedText).
	root addChild: elt2.

	elt3 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignLeft.
			        c frame vertical alignBottom ];
		        addChild:
			        (BlTextElement new text: 'left bottom' asRopedText).
	root addChild: elt3.

	elt4 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter.
			        c frame vertical alignTop ];
		        addChild: (BlTextElement new text: 'center top' asRopedText).
	root addChild: elt4.

	elt5 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter.
			        c frame vertical alignCenter ];
		        addChild:
			        (BlTextElement new text: 'center center' asRopedText).
	root addChild: elt5.

	elt6 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter.
			        c frame vertical alignBottom ];
		        addChild:
			        (BlTextElement new text: 'center bottom' asRopedText).
	root addChild: elt6.

	elt7 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight.
			        c frame vertical alignTop ];
		        addChild: (BlTextElement new text: 'right top' asRopedText).
	root addChild: elt7.

	elt8 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight.
			        c frame vertical alignCenter ];
		        addChild:
			        (BlTextElement new text: 'right center' asRopedText).
	root addChild: elt8.

	elt9 := BlElement new
		        size: 80 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: Color random;
		        margin: (BlInsets all: 5);
		        constraintsDo: [ :c |
			        c frame horizontal alignRight.
			        c frame vertical alignBottom ];
		        addChild:
			        (BlTextElement new text: 'right bottom' asRopedText).
	root addChild: elt9.

	^ root
]

{ #category : #examples }
LayoutExperiment class >> gridLayoutExample [

	<demo>
	<sampleInstance>
	| container e1 e2 e3 e4 e5 |

	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: (Color red alpha: 0.2);
		      border: (BlBorder paint: Color red width: 1).

	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: (Color yellow alpha: 0.2);
		      border: (BlBorder paint: Color yellow width: 1).
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: (Color blue alpha: 0.2);
		      border: (BlBorder paint: Color blue width: 1).

	e4 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: (Color green alpha: 0.2);
		      margin: (BlInsets all: 5);
		      border: (BlBorder paint: Color green width: 1).

	e5 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c grid horizontal span: 4 ];
		      background: (Color purple alpha: 0.2);
		      border: (BlBorder paint: Color purple width: 1).

	container := BlElement new
		             layout: (BlGridLayout new
				              columnCount: 4;
				              cellSpacing: 10);
		             background: Color veryLightGray;
		             border: (BlBorder paint: Color gray width: 3);
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ];
		             addChildren: {
				             e1.
				             e2.
				             e3.
				             e4.
				             e5 };
		             yourself.

	^ container
]

{ #category : #examples }
LayoutExperiment class >> layout1 [
	"This is a new method"
<demo>
	<sampleInstance>
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

{ #category : #examples }
LayoutExperiment class >> layout2 [
	"This is a new method"
<demo>
	<sampleInstance>
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

{ #category : #examples }
LayoutExperiment class >> layout3 [
	"This is a new method"
<demo>
	<sampleInstance>
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

{ #category : #examples }
LayoutExperiment class >> layout4 [
	"This is a new method"
<demo>
	<sampleInstance>
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

{ #category : #examples }
LayoutExperiment class >> layout5 [
	"This is a new method"
<demo>
	<sampleInstance>
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

{ #category : #examples }
LayoutExperiment class >> linearLayoutExample [
<demo>
	<sampleInstance>
	| root|
	root := BlElement new
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlLinearLayout horizontal;
		        constraintsDo: [ :c |
			        c horizontal fitContent.
			        c vertical fitContent ].

	"Child can use dynamic size with constraints. The number of element will then fit its 
	parents available space. 	If you specify their size, and the total is over its parents, 
	they will be hidden. need to specify their size. If they use constraint, the last one 
	will hide previous one. They will fit available space + move to next line if necessary"

	50 timesRepeat: [
		| elt |
		elt := BlElement new
			       border: (BlBorder paint: Color blue width: 1);
			       size: 40 @ 80;
			       background: (Color blue alpha: 0.2);
			       margin: (BlInsets all: 5);
			       padding: (BlInsets all: 5).

		root addChild: elt ].


	^ root
]

{ #category : #examples }
LayoutExperiment class >> multipleElement [
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

{ #category : #examples }
LayoutExperiment class >> multipleElement2 [
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
		        "layout: BlLinearLayout horizontal alignCenter ;"
		        constraintsDo: [ :c |
			        c horizontal matchParent.
			        c vertical matchParent ];
		        background: Color lightRed;
		        border: (BlBorder paint: Color red width: 5).
	element1 := BlElement new
		            size: 100 @ 100;
		            position: 50 @ 50;
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
		            geometryBounds: (BlBounds origin: 0 @ 0 extent: 50 @ 50);
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

{ #category : #examples }
LayoutExperiment class >> multipleElementAlignments [
<demo>
	<sampleInstance>
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
			            c vertical matchParent ];
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
		        layout: BlLinearLayout horizontal alignBottomLeft;
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

{ #category : #examples }
LayoutExperiment class >> multipleElementFitParameter [
<demo>
	<sampleInstance>
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
			        c horizontal fitContent.
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
			        c vertical fitContent ];
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

{ #category : #examples }
LayoutExperiment class >> multipleElementFitParameter2 [

	<demo>
	<sampleInstance>
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
			        c horizontal fitContent.
			        c vertical fitContent ];
		        background: Color lightRed;
		        border: (BlBorder paint: Color red width: 3).
	element1 := BlElement new
		            size: 20 @ 20;
		            geometry: (BlPolygonGeometry vertices: {
						             (10 @ 0).
						             (13 @ 8).
						             (20 @ 8).
						             (15 @ 12).
						             (17 @ 20).
						             (10 @ 16).
						             (3 @ 20).
						             (5 @ 12).
						             (0 @ 8).
						             (7 @ 8) });
		            border: (BlBorder paint: Color orange width: 1);
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
		            size: 20 @ 20;
		            geometry: (BlPolygonGeometry vertices: {
						             (10 @ 0).
						             (13 @ 8).
						             (20 @ 8).
						             (15 @ 12).
						             (17 @ 20).
						             (10 @ 16).
						             (3 @ 20).
						             (5 @ 12).
						             (0 @ 8).
						             (7 @ 8) });
		            border: (BlBorder paint: Color green width: 1);
		            transformDo: [ :t |
			            t scaleBy: (BlVector x: 4 y: 2 z: 1) "BlTransformationBuilder" ];
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
			        c vertical fitContent ];
		        background: Color lightBlue;
		        border: (BlBorder paint: Color blue width: 5).
	element3 := BlElement new
		            size: 20 @ 20;
		            geometry: (BlPolygonGeometry vertices: {
						             (10 @ 0).
						             (13 @ 8).
						             (20 @ 8).
						             (15 @ 12).
						             (17 @ 20).
						             (10 @ 16).
						             (3 @ 20).
						             (5 @ 12).
						             (0 @ 8).
						             (7 @ 8) });
		            border: (BlBorder paint: Color cyan width: 1);
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
LayoutExperiment class >> proportionalLayout [
<demo>
	<sampleInstance>
	| aContainer childA childB |
	childA := BlElement new
		          id: #childA;
		          background: Color red;
		          constraintsDo: [ :c |
			          c proportional horizontal
				          left: 0.2;
				          right: 0.4.
			          c proportional vertical
				          top: 0.1;
				          bottom: 0.5 ];
		          yourself.

	childB := BlElement new
		          id: #childB;
		          background: Color green;
		          constraintsDo: [ :c | c proportional horizontal left: 0.5 ];
		          yourself.

	aContainer := BlElement new
		              id: #container;
		              background: Color blue;
		              layout: BlProportionalLayout new;
		              size: 100 @ 100;
		              addChild: childA;
		              addChild: childB;
		              constraintsDo: [ :c |
			              c horizontal matchParent.
			              c vertical matchParent ];
		              padding: (BlInsets all: 5);
		              yourself.

	"aContainer openInNewSpace."
	^ aContainer
]

{ #category : #examples }
LayoutExperiment class >> proportionalLayout2 [
<demo>
	<sampleInstance>
	| aContainer childA childB childC |
	childA := BlElement new
		          id: #childA;
		          background: Color red;
		          constraintsDo: [ :c |
			          c proportional horizontal right: 0.33 ];
		          yourself.

	childB := BlElement new
		          id: #childB;
		          background: Color green;
		          constraintsDo: [ :c |
			          c proportional horizontal
				          left: 0.33;
				          right: 0.66 ];
		          yourself.

	childC := BlElement new
		          id: #child;
		          background: Color yellow;
		          constraintsDo: [ :c |
			          c proportional horizontal left: 0.66 ];
		          yourself.

	aContainer := BlElement new
		              id: #container;
		              background: Color blue;
		              layout: BlProportionalLayout new;
		              size: 100 @ 100;
		              addChild: childA;
		              addChild: childB;
		              addChild: childC;
		              constraintsDo: [ :c |
			              c horizontal matchParent.
			              c vertical matchParent ];
		              padding: (BlInsets all: 5);
		              yourself.

	"aContainer openInNewSpace."
	^ aContainer
]

{ #category : #examples }
LayoutExperiment class >> proportionalLayout3 [
<demo>
	<sampleInstance>
	| aContainer childA childB childC |
	childA := BlElement new
		          id: #childA;
		          background: Color red;
		          constraintsDo: [ :c |
			          c proportional horizontal right: 0.25.
			          c proportional vertical bottom: 0.25 ];
		          yourself.

	childB := BlElement new
		          id: #childB;
		          background: Color green;
		          constraintsDo: [ :c |
			          c proportional horizontal
				          left: 0.25;
				          right: 0.75.
			          c proportional vertical
				          top: 0.25;
				          bottom: 0.75 ];
		          yourself.

	childC := BlElement new
		          id: #child;
		          background: Color yellow;
		          constraintsDo: [ :c |
			          c proportional horizontal left: 0.75.
			          c proportional vertical top: 75 percent ];
		          yourself.

	aContainer := BlElement new
		              id: #container;
		              background: Color blue;
		              layout: BlProportionalLayout new;
		              addChildren: {
				              childA.
				              childB.
				              childC };
		              constraintsDo: [ :c |
			              c horizontal matchParent.
			              c vertical matchParent ];
		              padding: (BlInsets all: 5);
		              yourself.

	"aContainer openInNewSpace."
	^ aContainer
]

{ #category : #examples }
LayoutExperiment class >> spacingAndPaddindExampleWithTriangleGeometry [
<demo>
	<sampleInstance>
	| root element child |

	root := BlElement new
		        size: 400 @ 500;
		        geometry: BlTriangleGeometry new;
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFlowLayout horizontal alignCenter.

	element := BlElement new
		           border: (BlBorder paint: Color blue width: 1);
		           geometry: BlTriangleGeometry new;
		           background: (Color blue alpha: 0.2);
		           margin: (BlInsets all: 15);
		           padding: (BlInsets all: 25);
		           layout: BlFlowLayout horizontal alignCenter;
		           constraintsDo: [ :c |
			           c horizontal matchParent.
			           c vertical matchParent ].

	root addChild: element.


	child := BlElement new
		         border: (BlBorder paint: Color yellow width: 1);
		         geometry: BlTriangleGeometry new;
		         background: (Color yellow alpha: 0.2);
		         constraintsDo: [ :c |
			         c horizontal matchParent.
			         c vertical matchParent ].
	element addChild: child.
	
	^ root
]

{ #category : #examples }
LayoutExperiment class >> spacingAndPaddingdExample [
<demo>
	<sampleInstance>
	| root element child |

	root := BlElement new
		        size: 400 @ 400;
		        border: (BlBorder paint: Color red width: 1);
		        background: (Color red alpha: 0.2);
		        layout: BlFlowLayout horizontal alignCenter.
	"no dynamic constraints, we specify element size"

	element := BlElement new
		           border: (BlBorder paint: Color blue width: 1);
		           background: (Color blue alpha: 0.2);
		           margin: (BlInsets all: 15);
		           padding: (BlInsets all: 35);
		           "element has a child, specify its layoutSpec: "layout:
			           BlFlowLayout horizontal alignCenter;
		           "dynamic size computed relatively to its parent"
		           constraintsDo: [ :c |
			           c horizontal matchParent.
			           c vertical matchParent ].

	root addChild: element.

	child := BlElement new
		         border: (BlBorder paint: Color yellow width: 1);
		         background: (Color yellow alpha: 0.2);
		         "dynamic size computed relatively to its parent"
		         constraintsDo: [ :c |
			         c horizontal matchParent.
			         c vertical matchParent ].
	element addChild: child.

	^ root
]

{ #category : #examples }
LayoutExperiment class >> squareSurroundedByNumbers [
<demo>
	<sampleInstance>
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

{ #category : #tests }
LayoutExperiment class >> testLayout [

	<demo>
	<sampleInstance>
	| aContainer elt1 elt2 elt3 |
	elt1 := BlElement new
		        size: 40 @ 40;
		        border: (BlBorder paint: Color blue width: 1);
		        background: (Color blue alpha: 0.2);
		        constraintsDo: [ :c | c linear horizontal alignCenter ];
		        margin: (BlInsets all: 5).

	elt2 := BlElement new
		        size: 60 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: (Color red alpha: 0.2);
		        constraintsDo: [ :c | c linear horizontal alignCenter ];
		        margin: (BlInsets all: 5).

	elt3 := BlElement new
		        size: 100 @ 80;
		        border: (BlBorder paint: Color blue width: 1);
		        background: (Color yellow alpha: 0.2);
		        constraintsDo: [ :c |
			        c margin: (BlInsets left: 5 right: 5).
			        c linear horizontal alignCenter ];
		        margin: (BlInsets all: 5).


	aContainer := BlElement new
		              layout: BlLinearLayout horizontal alignCenter;
		              background: Color white;
		              margin: (BlInsets all: 20);
		              padding: (BlInsets all: 20);
		              constraintsDo: [ :c |
			              c vertical fitContent.
			              c horizontal fitContent.
			              c frame horizontal alignCenter.
			              c frame vertical alignCenter ].
	aContainer
		addChild: elt1;
		addChild: elt2;
		addChild: elt3.
	^ BlElement new
		  layout: BlFrameLayout new;
		  background: (Color orange alpha: 0.2);
		  constraintsDo: [ :c |
			  c vertical matchParent.
			  c horizontal matchParent ];
		  addChild: aContainer; yourself
]

{ #category : #examples }
LayoutExperiment class >> zoomLayoutExample [
<demo>
	<sampleInstance>
	| container elt |

	elt := BlElement new
		       size: 200 @ 200;
		       background: (Color blue alpha: 0.2);
		       border: (BlBorder paint: Color blue width: 1);
		       constraintsDo: [ :c | c accountTransformation ].

	container := BlElement new
		             background: Color white;
		             border: (BlBorder paint: Color gray width: 1);
		             geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		             padding: (BlInsets
				              top: 10
				              left: 10
				              bottom: 10
				              right: 10);
		             layout: (BlZoomableLayout new
				              addLayout: BlFrameLayout new;
				              defaultScale: 2;
				              animationDuration: 1 second);
		             constraintsDo: [ :c |
			             c vertical fitContent.
			             c horizontal fitContent ];
		             addChild: elt;
		             yourself.

	^ container
]

{ #category : #examples }
LayoutExperiment class >> zoomLayoutExample2 [
<demo>
	<sampleInstance>
	| elt zoom |

	elt := BlSvgIcons settingsIcon.
	elt
		border: (BlBorder paint: Color red width: 2);
		background: Color yellow;
		size: 24 @ 24;
		transformDo: [ :t | t scaleBy: 2 ];
		constraintsDo: [ :c | c accountTransformation ].


	zoom := BlElement new
		        background: Color white;
		        border: (BlBorder paint: Color gray width: 10);
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		        padding: (BlInsets all: 10);
		        layout: (BlZoomableLayout new
				         addLayout: BlFrameLayout new;
				         defaultScale: 5;
				         animationDuration: 2 second);
		        constraintsDo: [ :c |
			        c vertical fitContent.
			        c horizontal fitContent ];
		        addChild: elt;
		        yourself.

	^ zoom
]

{ #category : #'see class side' }
LayoutExperiment >> seeClassSide [ 
]

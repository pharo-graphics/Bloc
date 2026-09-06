Class {
	#name : #BlAnchorExamples,
	#superclass : #Object,
	#category : #'Bloc-Layout-Examples-Anchors'
}

{ #category : #anchors }
BlAnchorExamples class >> blueRectangle [

	| blue |
	blue := BlElement new
		        id: #blue;
		        yourself.
	blue background: Color blue.
	blue extent: 40 asPoint.
	^ blue
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorBottomLeftOnParentBottomLeft [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (blue bottomLeftAnchor on: pane bottomLeftAnchor)].
	  pane addChild: blue.
	  pane openInSpace.
	  ^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorBottomOnParentBottom [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (c anchors bottomAnchor on: c anchors parent bottomAnchor) ].
	  pane addChild: blue.
	  pane openInSpace.
	  ^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorBottomRightOnParentBottomRight [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (blue bottomRightAnchor on: pane bottomRightAnchor)].
	  pane addChild: blue.
	  pane openInSpace.
	  ^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorBottomRightOnPointAnchor [

	| pane blue |
	pane := self mainPane.
	blue := self blueRectangle.
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors bottomRightAnchor on:
					 (c anchors parent pointAnchor point: 41 asPoint)) ].
	pane addChild: blue.
	pane openInSpace.
	^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorExtentOnParentExtent [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (c anchors extentAnchor on: c anchors parent extentAnchor) ].
	  pane addChild: blue.
	  pane openInSpace.
	  ^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorLeftOnParentLeft [

	| pane blue |
	pane := self mainPane.
	blue := self blueRectangle.
	blue extent: 40 asPoint.
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (blue leftAnchor on: pane leftAnchor) ].
	pane addChild: blue.
	pane openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorRightOnParentRight [

	| pane blue |
	pane := self mainPane.
	blue := self blueRectangle.
	blue extent: 40 asPoint.
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors rightAnchor on: pane rightAnchor) ].
	pane addChild: blue.
	pane openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorTopOnParentTop [

	| pane blue |
	pane := self mainPane.
	blue := self blueRectangle.
	blue extent: 40 asPoint.
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (blue topAnchor on: pane topAnchor) ].
	pane addChild: blue.
	pane openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorWidthHeightOnParentWidthHeight [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (blue widthAnchor on: pane widthAnchor).
			  c anchors add: (blue heightAnchor on: pane heightAnchor) ].
	  pane addChild: blue.
	  pane openInSpace.
	  ^ pane
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorWidthHeightRightBottom [

	  | pane blue |
	  pane := self mainPane.
	  blue := self blueRectangle.
	  blue constraintsDo: [ :c |
			  c ignoreByLayout.
			  c anchors add: (blue rightAnchor on: pane rightAnchor).
			  c anchors add: (blue bottomAnchor on: pane bottomAnchor).
			  c anchors add: (blue heightAnchor on: pane heightAnchor).
			  c anchors add: (blue widthAnchor on: pane widthAnchor) ].
	  pane addChild: blue.
	  pane openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorsAroundCircle [

	| blue |
	blue := self example_AnchorsAroundRectangle.
	blue extent: 100 asPoint.
	blue geometry: BlCircleGeometry new
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorsAroundEllipse [

	| blue |
	blue := self example_AnchorsAroundRectangle.
	blue extent: 100 @ 70.
	blue geometry: BlEllipseGeometry new
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorsAroundRectangle [

	| pane blue |
	pane := self mainPane.
	pane layout: BlLinearLayout horizontal.
	10 timesRepeat: [
			| sub |
			sub := BlElement new.
			sub width: 60.
			sub constraintsDo: [ :c | c vertical matchParent ].
			sub background: (Color random alpha: 0.4).
			pane addChild: sub ].

	blue := self blueRectangle.
	blue margin: (BlInsets horizontal: 40 vertical: 40).
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(c anchors extentAnchor on: c anchors parent extentAnchor - 400 asPoint).
			c anchors add: (c anchors centerAnchor on: c anchors parent centerAnchor) ].

	pane addChild: blue.

	{ 0. 45. 90. 135. 180. 225. 270. 315 } do: [ :degrees |
			| deg lab |
			deg := BlElement new
				       id: degrees asString asSymbol;
				       layout: BlFrameLayout new;
				       yourself.
			lab := BlAttributedTextElement text:
				       (degrees asString , '°') asRopedText.
			lab foreground: Color white.
			lab constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			deg addChild: lab.
			deg background: Color gray.
			deg extent: 24 @ 22.
			deg constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add:
						(c anchors centerAnchor on: (blue perimeterAnchor degrees: degrees)) ].
			pane addChild: deg ].

	pane openInSpace.
	^ blue
]

{ #category : #anchors }
BlAnchorExamples class >> example_AnchorsAroundRoundRectangle [

	| blue |
	blue := self example_AnchorsAroundRectangle.
	blue margin: (BlInsets all: 10).
	blue extent: 200 @ 200.
	blue geometry: (BlRoundedRectangleGeometry cornerRadius: 50)
]

{ #category : #anchors }
BlAnchorExamples class >> example_CenterLayout [

	| pane pink blue red green |
	pane := self mainPane.
	blue := self blueRectangle.
	blue extent: 150 asPoint.
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (blue centerAnchor on: pane centerAnchor) ].
	pane addChild: blue.

	pink := BlElement new
		        id: #pink;
		        yourself.
	pink background: Color pink.
	pink extent: 100 asPoint.
	pink constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (pink centerAnchor on: blue centerAnchor) ].
	blue addChild: pink.


	red := BlElement new
		       id: #red;
		       yourself.
	red background: Color red.
	red extent: 20 asPoint.
	red constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (red centerAnchor on: pink centerAnchor) ].
	pane addChild: red.


	green := BlElement new
		         id: #green;
		         yourself.
	green background: Color green.
	green extent: 10 @ 10.

	green constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add: (c anchors topAnchor on: red topAnchor).
			c anchors add: (c anchors heightAnchor on: pink heightAnchor).
			c anchors add: (c anchors rightAnchor on: blue leftAnchor) ].
	pane addChild: green.

	pane openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> example_PerimeterAnchorOnLeftHandSide [

	| pane blue red |
	pane := self mainPane.
	blue := self blueRectangle.
	blue extent: 100 @ 50.
	blue margin: (BlInsets horizontal: 40 vertical: 40).
	blue constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(blue verticalCenterAnchor on: pane verticalCenterAnchor).
			c anchors add:
				(blue horizontalCenterAnchor on: pane horizontalCenterAnchor) ].

	pane addChild: blue.

	red := BlElement new
		       id: #red;
		       layout: BlFrameLayout new;
		       yourself.
	red background: Color red.
	red extent: 24 @ 22.
	red constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				((red perimeterAnchor degrees: 90) on: blue bottomLeftAnchor) ].
	pane addChild: red.

	pane openInSpace.
	^ blue
]

{ #category : #anchors }
BlAnchorExamples class >> example_pointOnPerimeterAtRadians [

	| view element count points angle polygon |
	view := BlElement new.
	view constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].
	view background: Color white.

	"Créer un élément arrondi simple, sans marges"
	element := BlElement new.
	element margin: (BlInsets all: 10).
	element geometry: (BlRoundedRectangleGeometry cornerRadius: 50).
	element extent: 300 @ 100.
	element position: 30 @ 30.
	element background: Color lightGray.
	view addChild: element.
	view forceLayout.

	"Calculer les points sur le périmètre"
	count := 1000.
	points := (0 to: count - 1) collect: [ :i |
			          angle := 2 * Float pi * i / count.
			          element geometry
				          pointOnPerimeterOfElement: element
				          atRadians: angle ].

	"Tracer une polyligne pour relier les points"
	polygon := (BlPolygonGeometry vertices: points) asElement.
	polygon border: Color red.
	view addChild: polygon.

	"Afficher les points en petits cercles"
	points do: [ :pt |
			| dot |
			dot := BlElement new.
			dot geometry: BlEllipseGeometry new.
			dot extent: 2 @ 2.
			dot position: pt - (1 @ 1).
			dot background: Color blue.
			view addChild: dot ].

	view openInSpace
]

{ #category : #anchors }
BlAnchorExamples class >> mainPane [

	  | pane |
	  pane := BlElement new
		          id: #pane;
		          yourself.
	  pane constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ].
	  pane layout: BlBasicLayout new.
	  pane border: Color red.
	  ^ pane
]

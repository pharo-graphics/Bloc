"
I have been automatically converted and probably manually tweaked from BlBasicExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlBasicTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Basic'
}

{ #category : #tests }
BlBasicTest >> testAsForm [

	| anElement |
	anElement := BlElement new
		extent: 30@40;
		background: Color green;
		yourself.

	self assert: anElement asForm extent equals: 30@40.

	anElement position: 10@20.
	self assert: anElement asForm extent equals: 30@40.

	anElement transformDo: [ :t | t scaleBy: 2@3 ].
	self assert: anElement asForm extent equals: 60@120.

	self
		assert: (anElement asForm colorAt: 0@0)
		equals: Color green
]

{ #category : #tests }
BlBasicTest >> testBorderRopedText [

	<sampleInstance>
	| aText |
	aText := 'Text with border' asRopedText.
	aText fontSize: 30.
	aText foreground: Color gray.
	aText thin.
	self assert: aText rope attributes equals: {
			(BlFontSizeAttribute size: 30).
			(BlTextForegroundAttribute paint: Color gray).
			BlFontWeightAttribute thin }.
	^ aText
]

{ #category : #tests }
BlBasicTest >> testBorderTextElement [

	<sampleInstance>
	<demo>
	| aText |
	aText := self testBorderRopedText.

	^ BlTextElement new
		  text: aText;
		  constraintsDo: [ :c |
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ]
]

{ #category : #tests }
BlBasicTest >> testBottomBorder [

	<sampleInstance>
	^ self testHorizontalBorder constraintsDo: [ :c |
		  c frame vertical alignBottom ]
]

{ #category : #tests }
BlBasicTest >> testButtons [

	<sampleInstance>
	<demo>
	^ self testContainer
		  addChild: (self testColoredButton position: 100 @ 100);
		  addChild: (self testFabButton position: 300 @ 88);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testCircle [

	<sampleInstance>
	<demo>
	^ BlElement new
		  geometry: BlCircleGeometry new;
		  background: (Color red alpha: 0.8);
		  border: (BlBorder paint: (Color blue alpha: 0.5) width: 6);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testColoredButton [

	<sampleInstance>
	<demo>
	| button labelText label |
	button := BlElement new
		          background: (Color
				           r: 63
				           g: 81
				           b: 181
				           range: 255);
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          position: 100 @ 100;
		          padding: (BlInsets
				           top: 8
				           right: 16
				           bottom: 8
				           left: 16);
		          layout: BlLinearLayout horizontal;
		          effect: (BlGaussianShadowEffect
				           color: (Color black alpha: 0.3)
				           width: 1
				           offset: 0 @ 2);
		          constraintsDo: [ :c |
			          c horizontal fitContent.
			          c vertical fitContent ].

	labelText := 'Button' asRopedText
		             foreground: Color white;
		             fontSize: 16;
		             fontName: 'Helvetica';
		             thin.

	label := BlTextElement new.
	label text: labelText.

	button addChild: label.
	^ button
]

{ #category : #tests }
BlBasicTest >> testContainer [

	<sampleInstance>
	<demo>
	^ BlElement new
		  background: Color white;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  yourself
]

{ #category : #tests }
BlBasicTest >> testElementWithAllBorders [

	<sampleInstance>
	<demo>
	^ self testContainer
		  layout: BlFrameLayout new;
		  extent: 300 @ 150;
		  position: 50 @ 50;
		  addChild: (self testLeftBorder background: Color green darker);
		  addChild: (self testRightBorder background: Color yellow darker);
		  addChild: (self testTopBorder background: Color blue);
		  addChild: (self testBottomBorder background: Color red)
]

{ #category : #tests }
BlBasicTest >> testElementWithEllipticBorders [

	<sampleInstance>
	<demo>
	^ self testContainer
		  layout: BlFrameLayout new;
		  extent: 300 @ 150;
		  position: 50 @ 50;
		  addChild: (self testLeftBorder
				   background: (Color gray alpha: 0.3);
				   geometry: BlEllipseGeometry new);
		  addChild: (self testRightBorder
				   background: (Color gray alpha: 0.3);
				   geometry: BlEllipseGeometry new);
		  addChild: (self testTopBorder
				   background: (Color gray alpha: 0.3);
				   geometry: BlEllipseGeometry new);
		  addChild: (self testBottomBorder
				   background: (Color gray alpha: 0.3);
				   geometry: BlEllipseGeometry new);
		  addChild: self testBorderTextElement
]

{ #category : #tests }
BlBasicTest >> testElementsWithShadow [

	<sampleInstance>
	<demo>
	^ self testContainer addChildren: {
			  (self testRectangleWithShadow position: 50 @ 100).
			  (self testEllipseWithShadow position: 500 @ 100) }
]

{ #category : #tests }
BlBasicTest >> testEllipse [

	<sampleInstance>
	^ (BlEllipseGeometry new extent: 200 @ 100) asElement
		  background: (Color red alpha: 0.5);
		  border: (BlBorder paint: Color black width: 2);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testEllipseWithShadow [

	<sampleInstance>
	<demo>
	^ BlElement new
		  geometry: BlEllipseGeometry new;
		  extent: 300 @ 150;
		  position: 50 @ 50;
		  border: (BlBorder paint: Color black width: 2);
		  background: Color red;
		  effect: self testShadowEffect;
		  yourself
]

{ #category : #tests }
BlBasicTest >> testFabButton [

	<sampleInstance>
	<demo>
	| button icon |
	button := BlElement new
		          background: (Color
				           r: 255
				           g: 64
				           b: 129
				           range: 255);
		          geometry: BlEllipseGeometry new;
		          position: 100 @ 100;
		          extent: 56 @ 56;
		          layout: BlFrameLayout new;
		          effect: (BlGaussianShadowEffect
				           color: (Color black alpha: 0.3)
				           width: 1
				           offset: 0 @ 2).

	icon := (BlPolygonGeometry vertices: ({
			          (36 @ 0).
			          (48 @ 0).
			          (48 @ 36).
			          (84 @ 36).
			          (84 @ 48).
			          (48 @ 48).
			          (48 @ 84).
			          (36 @ 84).
			          (36 @ 48).
			          (0 @ 48).
			          (0 @ 36).
			          (36 @ 36) } collect: [ :aPoint | aPoint / 6.0 ]))
		        asElement.

	icon background: Color white.
	icon border: BlBorder empty.
	icon constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: icon.
	^ button
]

{ #category : #tests }
BlBasicTest >> testHorizontalBorder [
	<sampleInstance>
	^ BlElement new constraintsDo: [ :c |
		  c vertical exact: 20.
		  c horizontal matchParent ]
]

{ #category : #tests }
BlBasicTest >> testLeftBorder [

	<sampleInstance>
	^ self testVerticalBorder constraintsDo: [ :c |
		  c frame horizontal alignLeft ]
]

{ #category : #tests }
BlBasicTest >> testLinearGradient [

	<sampleInstance>
	^ BlLinearGradientPaint new
		  stops: {
				  (0.0 -> Color white).
				  (0.5 -> Color gray).
				  (1.0 -> Color veryDarkGray) };
		  start: 0 @ 0;
		  end: 300 @ 200;
		  yourself
]

{ #category : #tests }
BlBasicTest >> testPolygon [

	<sampleInstance>
	<demo>
	^ (BlPolygonGeometry vertices: {
				   (100 @ 10).
				   (40 @ 198).
				   (190 @ 78).
				   (10 @ 78).
				   (160 @ 198) }) asElement
		  extent: 200 @ 200;
		  background: (Color blue alpha: 0.4);
		  outskirts: BlOutskirts outside;
		  border: (BlBorder paint: Color darkGray width: 2);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testRectangle [

	<sampleInstance>
	<demo>
	^ BlElement new
		  geometry: BlRoundedRectangleGeometry new;
		  extent: 200 @ 100;
		  background: Color transparent;
		  effect: BlGaussianShadowEffect new;
		  border: (BlBorder paint: Color blue width: 4);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testRectangleWithImage [

	<sampleInstance>
	<demo>
	^ BlElement new
		  extent: 400 @ 200;
		  position: 100 @ 100;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background:
			  BlBackgroundTest new testBuildBackgroundWithImagesAndColor;
		  yourself
]

{ #category : #tests }
BlBasicTest >> testRectangleWithLinearGradient [

	<sampleInstance>
	<demo>
	^ BlElement new
		  extent: 300 @ 200;
		  position: 100 @ 100;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 40);
		  background: self testLinearGradient;
		  yourself
]

{ #category : #tests }
BlBasicTest >> testRectangleWithShadow [

	<sampleInstance>
	<demo>
	^ BlElement new
		  extent: 300 @ 150;
		  position: 50 @ 50;
		  border: (BlBorder paint: Color black width: 2);
		  background: Color red;
		  effect: self testShadowEffect;
		  yourself
]

{ #category : #tests }
BlBasicTest >> testRightBorder [

	<sampleInstance>
	^ self testVerticalBorder constraintsDo: [ :c |
		  c frame horizontal alignRight ]
]

{ #category : #tests }
BlBasicTest >> testRoundedRectangle [

	<sampleInstance>
	<demo>
	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 20);
		  extent: 150 @ 80;
		  background: Color yellow;
		  border: (BlBorder paint: Color red width: 7);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testShadowEffect [
	<sampleInstance>
	 
	^ BlGaussianShadowEffect color: Color black width: 10 offset: 10 @ 10
]

{ #category : #tests }
BlBasicTest >> testShapes [

	<sampleInstance>
	^ self testContainer addChildren: {
			  (self testCircle position: 250 @ 200).
			  (self testEllipse position: 10 @ 20).
			  (self testPolygon position: 220 @ 0).
			  (self testRectangle position: 10 @ 190).
			  (self testRoundedRectangle position: 430 @ 50).
			  (self testSquare position: 400 @ 200) }
]

{ #category : #tests }
BlBasicTest >> testSquare [

	<sampleInstance>
	<demo>
	^ BlElement new
		  geometry: BlRoundedRectangleGeometry new;
		  extent: 80 @ 80;
		  background: Color green;
		  border: (BlBorder paint: Color black width: 2);
		  yourself
]

{ #category : #tests }
BlBasicTest >> testTopBorder [
	<sampleInstance>
	
	^ self testHorizontalBorder constraintsDo: [ :c |
		  c frame vertical alignTop ]
]

{ #category : #tests }
BlBasicTest >> testVerticalBorder [

	<sampleInstance>
	^ BlElement new constraintsDo: [ :c |
		  c horizontal exact: 20.
		  c vertical matchParent ]
]

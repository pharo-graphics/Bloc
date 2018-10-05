"
I am a collection of basic most simple examples that show most important Bloc features
"
Class {
	#name : #BlBasicExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'Bloc-Examples-Basic'
}

{ #category : #examples }
BlBasicExamples class >> buttons [
	<script: 'self buttons'>
	
	self
		openInWindow: self new buttons
		named: 'Buttons'
		extent: 470@250
]

{ #category : #examples }
BlBasicExamples class >> compositeBorder [
	<script: 'self compositeBorder'>
	self
		openInWindow: self new elementWithAllBorders
		named: 'Composite border'
		extent: 400 @ 250
]

{ #category : #examples }
BlBasicExamples class >> imageBackground [
	<script: 'self imageBackground'>
	self
		openInWindow: self new rectangleWithImage
		named: 'Image background'
		extent: 600 @ 400
]

{ #category : #examples }
BlBasicExamples class >> linearGradientBackground [
	<script: 'self linearGradientBackground'>

	self
		openInWindow: self new rectangleWithLinearGradient
		named: 'Linear gradient background'
		extent: 500 @ 400
]

{ #category : #examples }
BlBasicExamples class >> shadow [
	<script: 'self shadow'>

	self
		openInWindow: self new elementsWithShadow
		named: 'Shadow'
		extent: 900 @ 350
]

{ #category : #examples }
BlBasicExamples class >> shapes [
	<script: 'self shapes'>

	self
		openInWindow: self new shapes
		named: 'Shapes'
		extent: 600 @ 350
]

{ #category : #'examples - border' }
BlBasicExamples >> borderRopedText [
	<gtExample>
	| aText |
	
	aText := 'Text with border' asRopedText.
	aText fontSize: 30.
	aText foreground: Color gray.
	aText thin.
	
	self
		assert: aText rope attributes
		equals: {
			BrFontSizeAttribute size: 30.
			BrTextForegroundAttribute paint: Color gray.
			BrFontWeightAttribute thin }.

	^ aText
]

{ #category : #'examples - border' }
BlBasicExamples >> borderTextElement [
	<gtExample>
	| aText |

	aText := self borderRopedText.

	^ BlTextElement new
		text: aText;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ]
]

{ #category : #'examples - border' }
BlBasicExamples >> bottomBorder [
	<gtExample>

	^ self horizontalBorder
		constraintsDo: [ :c |
			c frame vertical alignBottom ]
]

{ #category : #'examples - buttons' }
BlBasicExamples >> buttons [
	<gtExample>
	
	^ self container
		addChild: (self coloredButton relocate: 100@100);
		addChild: (self fabButton relocate: 300@88);
		yourself
]

{ #category : #'examples - shape' }
BlBasicExamples >> circle [
	<gtExample>

	^ BlElement new
		geometry: BlCircle new;
		background: (Color red alpha: 0.8);
		border: (BlBorder paint: (Color blue alpha: 0.5) width: 6);
		yourself
]

{ #category : #'examples - buttons' }
BlBasicExamples >> coloredButton [
	<gtExample>
	| button labelText label |
	
	button := BlElement new
		background: (Color r: 63 g: 81 b: 181 range: 255);
		geometry: (BlRectangle cornerRadius: 2);
		relocate: 100@100;
		padding: (BlInsets top: 8 right: 16 bottom: 8 left: 16);
		layout: BlLinearLayout horizontal;
		effect: (BlDropShadowEffect color: (Color black alpha: 0.3) width: 1 offset: 0@2);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].

	labelText := 'Button' asRopedText.
	labelText attributes: {
		BrTextForegroundAttribute paint: Color white.
		BrFontSizeAttribute size: 16.
		BrFontFamilyAttribute named: 'Helvetica'.
		BrFontWeightAttribute thin
	}.

	label := BlTextElement new.
	label text: labelText.

	button addChild: label.
	^ button
]

{ #category : #'instance creation' }
BlBasicExamples >> container [
	<gtExample>
	
	^ BlElement new
		background: Color white;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'examples - border' }
BlBasicExamples >> elementWithAllBorders [
	<gtExample>
	
	^ self container
		layout: BlFrameLayout new;
		size: 300@150;
		relocate: 50@50;
		addChild: (self leftBorder background: Color green darker);
		addChild: (self rightBorder background: Color yellow darker);
		addChild: (self topBorder background: Color blue);
		addChild: (self bottomBorder background: Color red)
]

{ #category : #'examples - border' }
BlBasicExamples >> elementWithEllipticBorders [
	<gtExample>

	^ self container
		layout: BlFrameLayout new;
		size: 300@150;
		relocate: 50@50;
		addChild: (self leftBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self rightBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self topBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: (self bottomBorder background: (Color gray alpha: 0.3); geometry: BlEllipse new);
		addChild: self borderTextElement
]

{ #category : #'examples - shadow' }
BlBasicExamples >> elementsWithShadow [
	<gtExample>
	
	^ self container
		addChildren: {
			self rectangleWithShadow relocate: 50@100.
			self ellipseWithShadow relocate: 500 @ 100 }
]

{ #category : #'examples - shape' }
BlBasicExamples >> ellipse [
	<gtExample>
	
	^ (BlEllipse extent: 200 @ 100) asElement
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 2);
		yourself
]

{ #category : #'examples - shadow' }
BlBasicExamples >> ellipseWithShadow [
	<gtExample>
	
	^ BlElement new
		geometry: BlEllipse new;
		size: 300@150;
		relocate: 50@50;
		border: (BlBorder paint: Color black width: 2);
		background: Color red;
		effect: self shadowEffect;
		yourself.
]

{ #category : #'examples - buttons' }
BlBasicExamples >> fabButton [
	<gtExample>
	| button icon |

	button := BlElement new
		background: (Color r: 255 g: 64 b: 129 range: 255);
		geometry: BlEllipse new;
		relocate: 100@100;
		size: 56@56;
		layout: BlFrameLayout new;
		effect: (BlDropShadowEffect color: (Color black alpha: 0.3) width: 1 offset: 0@2).

	icon := (BlPolygon vertices: ({
			36@0. 48@0 . 48@36 . 84@36.
			84@48 . 48@48 . 48@84 . 36@84.
			36@48 . 0@48 . 0@36. 36@36
		} collect: [ :aPoint | aPoint / 6.0])) asElement.

	icon background: Color white.
	icon border: BlBorder empty.
	icon constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: icon.
	^ button
]

{ #category : #'examples - border' }
BlBasicExamples >> horizontalBorder [
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: 20.
			c horizontal matchParent ]
]

{ #category : #'examples - border' }
BlBasicExamples >> leftBorder [
	<gtExample>

	^ self verticalBorder
		constraintsDo: [ :c |
			c frame horizontal alignLeft ]
]

{ #category : #'examples - shape' }
BlBasicExamples >> line [
	<gtExample>

	^ BlLineElement new
		fromAnchor: (BlAbsolutePositionAnchor position: 75 @ 140);
		toAnchor: (BlAbsolutePositionAnchor position: 200 @ 240);
		border: (BlBorder paint: Color red width: 4);
		yourself
]

{ #category : #'examples - background' }
BlBasicExamples >> linearGradient [
	<gtExample>
	
	^ BlLinearGradientPaint new
		stops: {
			(0.0 -> Color white).
			(0.5 -> Color gray).
			(1.0 -> Color veryDarkGray)
		};
		start: 0@0;
		end: 300@200;
		yourself
]

{ #category : #'examples - shape' }
BlBasicExamples >> polygon [
	<gtExample>
	
	^ (BlPolygon vertices: { 100@10. 40@198. 190@78. 10@78. 160@198} ) asElement
		size: 200@200;
		background: (Color blue alpha: 0.4);
		outskirts: BlOutskirts outside;
		border: (BlBorder
			paint: Color darkGray
			width: 2);
		yourself
]

{ #category : #'examples - shape' }
BlBasicExamples >> rectangle [
	<gtExample>
	
	^ BlElement new
		geometry: BlRectangle new;
		size: 200 @ 100;
		background: Color transparent;
		effect: (BlBlurBelowEffect radius: 4);
		border: (BlBorder paint: Color blue width: 4);
		yourself
]

{ #category : #'examples - background' }
BlBasicExamples >> rectangleWithImage [
	<gtExample>

	^ BlElement new
		size: 400@200;
		relocate: 100 @ 100;
		geometry: (BlRectangle cornerRadius: 10);
		background: BlBackgroundExamples new buildBackgroundWithImagesAndColor;
		yourself
]

{ #category : #'examples - background' }
BlBasicExamples >> rectangleWithLinearGradient [
	<gtExample>

	^ BlElement new
		size: 300@200;
		relocate: 100 @ 100;
		geometry: (BlRectangle cornerRadius: 40);
		background: self linearGradient;
		yourself
]

{ #category : #'examples - shadow' }
BlBasicExamples >> rectangleWithShadow [
	<gtExample>
	
	^ BlElement new
		size: 300@150;
		relocate: 50@50;
		border: (BlBorder paint: Color black width: 2);
		background: Color red;
		effect: self shadowEffect;
		yourself.
]

{ #category : #'examples - border' }
BlBasicExamples >> rightBorder [
	<gtExample>
	
	^ self verticalBorder
		constraintsDo: [ :c |
			c frame horizontal alignRight ]
]

{ #category : #'examples - shape' }
BlBasicExamples >> roundedRectangle [
	<gtExample>
	
	^ BlElement new
		geometry: (BlRectangle cornerRadius: 20);
		size: 150@80;
		background: Color yellow;
		border: (BlBorder paint: Color red width: 7);
		yourself
]

{ #category : #'examples - shadow' }
BlBasicExamples >> shadowEffect [
	<gtExample>
	
	^ BlDropShadowEffect color: Color black width: 20 offset: 10@10
]

{ #category : #'examples - composition' }
BlBasicExamples >> shapes [
	<gtExample>
	
	^ self container
		addChildren: { 
			self circle relocate: 250 @ 200.
			self ellipse relocate: 10 @ 20.
			self line.
			self polygon relocate: 220 @ 0.
			self rectangle relocate: 10 @ 190.
			self roundedRectangle relocate: 430 @ 50.
			self square relocate: 400 @ 200.
		}
]

{ #category : #'examples - shape' }
BlBasicExamples >> square [
	<gtExample>

	^ BlElement new
		geometry: BlRectangle new;
		size: 80@80;
		background: Color green;
		border: (BlBorder paint: Color black width: 2);
		yourself
]

{ #category : #'examples - border' }
BlBasicExamples >> topBorder [
	<gtExample>

	^ self horizontalBorder
		constraintsDo: [ :c |
			c frame vertical alignTop ]
]

{ #category : #'examples - border' }
BlBasicExamples >> verticalBorder [
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 20.
			c vertical matchParent ]
]

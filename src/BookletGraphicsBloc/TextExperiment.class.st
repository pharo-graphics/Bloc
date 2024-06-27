"
text experiment and example in bloc
- font selection
- font effect (background and foreground color)
- etc.
"
Class {
	#name : #TextExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
TextExperiment class >> exampleHelloWorld [

	<simpleInstance>
	| elt |
	elt := BlTextElement new text: 'Hello world!' asRopedText.
	elt openInNewSpace.
	^ elt
]

{ #category : #examples }
TextExperiment class >> helloBloc [

	<sampleInstance>
	| labelText label |
	labelText := 'hello from bloc' asRopedText
		             background: Color orange ;
		             fontSize: 75;
		             fontName: 'Source Code Pro';
		             italic;
		             underline;
		             underlineColor: Color red;
		             vertical.

	(labelText from: 1 to: 5) foreground: Color blue.
	(labelText from: 7 to: 11) foreground: Color white.
	(labelText from: 12 to: 15) foreground: Color red.

	label := (BlTextElement text: labelText) position: 50 @ 10; background: Color yellow.

	label openInNewSpace.
	^ label
]

{ #category : #examples }
TextExperiment class >> helloHarfbuzz [

	<sampleInstance>
	| labelText label |
	"Harfbuzz rendering is currently commented out in BATextParagraphSpan >> measure "
	labelText := 'a := A->B->>C <= c|=>d~~>e.' asRopedText
		             background: Color orange;
		             fontSize: 25;
		             fontName: 'Cascadia Code';
						 underline;
						 underlineColor: Color red.

	(labelText from: 1 to: 5) foreground: Color blue.
	(labelText from: 7 to: 11) foreground: Color white.
	(labelText from: 12 to: 15) foreground: Color red.
	
	label := (BlTextElement text: labelText)
		         position: 50 @ 10;
		         background: Color yellow;
		         margin: (BlInsets all: 10);
		         padding: (BlInsets all: 5);
		         outskirts: BlOutskirts centered;
		         border: (BlBorder paint: Color red width: 5).
	label tightMeasurement.

	^ label



]

{ #category : #examples }
TextExperiment class >> sampleEditorMeasure [

	<sampleInstance>
	| labelText label |
	labelText := 'Sphinx - a := A->B->>C <= c|=>d~~>e.' asRopedText
		             background: Color orange;
		             fontSize: 25;
		             fontName: 'Cascadia Code'.

	label := (BlTextElement text: labelText)
		         background: Color yellow;
		         "margin: (BlInsets all: 5);"
		         "padding: (BlInsets all: 5);"
		         "outskirts: BlOutskirts outside;"
		         border: (BlBorder paint: Color red width: 1).
	label editorMeasurement.
	^ label
]

{ #category : #examples }
TextExperiment class >> sampleLabelMeasure [

	<sampleInstance>
	| labelText label |
	labelText := 'Sphinx - a := A->B->>C <= c|=>d~~>e.' asRopedText
		             background: Color orange;
		             fontSize: 25;
		             fontName: 'Cascadia Code'.

	label := (BlTextElement text: labelText)
		         background: Color yellow;
		         "margin: (BlInsets all: 5);"
		         "padding: (BlInsets all: 5);"
		         "outskirts: BlOutskirts outside;"
		         border: (BlBorder paint: Color red width: 1).
	label labelMeasurement.

	^ label
]

{ #category : #examples }
TextExperiment class >> sampleMeasure [

	<sampleInstance>
	| container |
	container := BlElement new
		             border: (BlBorder paint: Color black width: 2);
		             layout: BlLinearLayout vertical alignCenterLeft ;
		 				padding: (BlInsets all: 5);
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ];
		transformDo: [ :t |
			"Zoom in, to better appreciate children details"
			t topLeftOrigin; scaleBy: 3 ].

	container addChildren: {
			BlTextElement text: 'editor measure' asRopedText.
			self sampleEditorMeasure.
			BlTextElement text: 'label measure' asRopedText.
			self sampleLabelMeasure.
			BlTextElement text: 'tight measure' asRopedText.
			self sampletightMeasure }.
	container openInNewSpace.
	^ container
]

{ #category : #examples }
TextExperiment class >> sampletightMeasure [

	<sampleInstance>
	| labelText label |
	labelText := 'Sphinx - a := A->B->>C <= c|=>d~~>e.' asRopedText
		             background: Color orange;
		             fontSize: 25;
		             fontName: 'Cascadia Code'.

	label := (BlTextElement text: labelText)
		         background: Color yellow;
		         "margin: (BlInsets all: 5);"
		         "padding: (BlInsets all: 5);"
		         "outskirts: BlOutskirts outside;"
		         border: (BlBorder paint: Color red width: 1).
	label tightMeasurement.

	^ label
]

{ #category : #examples }
TextExperiment class >> textAlignment1 [

	<sampleInstance>
	| t1 t2 p |
	t1 := BlTextElement text: 'Element' asRopedText.
	t2 := BlTextElement text: 'Élément' asRopedText.

	p := BlElement new
		     layout: BlLinearLayout horizontal;
		     constraintsDo: [ :c |
			     c horizontal fitContent.
			     c vertical fitContent ];
		     addChildren: {
				     t1.
				     t2 };
		     transformDo: [ :t | t scaleBy: 3.0 ].

	"force size calculation"
	p forceLayout.
	t1 transformDo: [ :t | t translateBy: 0 @ (t2 height - t1 height) ].

	^ p
]

{ #category : #examples }
TextExperiment class >> textAlignment2 [

	<sampleInstance>
	| t1 t2 p |
	t1 := BlTextElement text: 'Element' asRopedText.
	t1 constraintsDo: [ :c |
			     c linear vertical alignBottom.
			     c linear horizontal alignCenter ].
	t2 := BlTextElement text: 'Élément' asRopedText.
	

	p := BlElement new
		     layout: BlLinearLayout horizontal;
		     constraintsDo: [ :c |
			     c horizontal fitContent.
			     c vertical fitContent ];
		     addChildren: {
				     t1.
				     t2 };
		     transformDo: [ :t | t scaleBy: 3.0 ].

	^ p
]

{ #category : #'see class side' }
TextExperiment >> seeClassSide [ 
]

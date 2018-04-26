debugging triangle and text
iconAndTextContainer
	<gtExample>
	| aContainerElement |
	aContainerElement := BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.3);
		padding: (BlInsets all: 3);
		margin: (BlInsets left: 5).
	aContainerElement
		transformDo: [ :t | 
			t origin: BlAffineTransformationTopLeftOrigin new.
			t scaleBy: 5 ].
	^ aContainerElement
debugging triangle and text
alignedIcon
	<gtExample>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := BlElement new
		size: 8 @ 12;
		geometry: self trianglePolygon;
		background: Color green muchDarker.
	aLabelElement := BlTextElement new text: 'Run' asRopedText.
	aContainerElement := BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.3);
		padding: (BlInsets all: 3).
	aContainerElement
		transformDo: [ :t | 
			t origin: BlAffineTransformationTopLeftOrigin new.
			t scaleBy: 10 ].
	aContainerElement margin: (BlInsets left: 5).
	aContainerElement
		addChildren:
			{anIconElement.
			aLabelElement}.
	^ aContainerElement
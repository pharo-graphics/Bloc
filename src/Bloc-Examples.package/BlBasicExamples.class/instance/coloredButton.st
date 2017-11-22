examples - buttons
coloredButton
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
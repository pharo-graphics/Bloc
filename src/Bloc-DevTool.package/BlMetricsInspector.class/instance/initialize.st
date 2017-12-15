initialization
initialize
	super initialize.
	
	extentMetric := self newExtentMetric.
	extentMetric padding: (BlInsets top: 15 right: 55 bottom: 15 left: 55).
	extentMetric text: ('content' asRopedText attributes: {
		BrFontFamilyAttribute named: 'Helvetica Neue'.
		BrFontEmphasisAttribute italic.
		BrFontSizeAttribute size: 15
	}).
	extentMetric background: Color white.

	paddingMetric := self newMetric.
	paddingMetric label: 'padding'.
	paddingMetric border: (BlBorder builder paint: (Color black alpha: 0.7); width: 2; build).
	paddingMetric background: (Color paleGreen lighter).
	paddingMetric content: extentMetric.

	marginMetric := self newMetric.
	marginMetric label: 'margin'.
	marginMetric background: (Color paleOrange lighter).
	marginMetric content: paddingMetric.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self addChild: marginMetric
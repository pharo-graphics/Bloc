initialization
initialize
	super initialize.
	
	extentMetric := self newExtentMetric.
	extentMetric padding: (BlInsets top: 8 right: 15 bottom: 8 left: 15).
	extentMetric border: (BlBorder paint: Color gray width: 1).
	extentMetric text: (BrRopedText string: (self extentTextFor: 0@0)).
	extentMetric background: Color white.

	paddingMetric := self newMetric.
	paddingMetric label: 'padding'.
	paddingMetric border: (BlBorder paint: (Color red alpha: 0.7) width: 1 style: BlStrokeStyle SOLID).
	paddingMetric content: extentMetric.
	paddingMetric background: Color paleRed.

	marginMetric := self newMetric.
	marginMetric label: 'margin'.
	marginMetric border: (BlBorder paint: Color blue lighter width: 1 style: BlStrokeStyle DASHED).	
	marginMetric content: paddingMetric.
	marginMetric background: Color blue muchLighter lighter lighter.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self addChild: marginMetric.
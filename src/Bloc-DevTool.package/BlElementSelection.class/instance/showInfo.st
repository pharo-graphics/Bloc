actions
showInfo
	| extentTextElement |
	
	self padding: self client margin + self extraPadding.
	self relocate: self selectionPosition.
	self size: self selectionExtent.

	self effect: (BlBlurBelowEffect radius: 1.5).
	self background: (Color white alpha: 0.5).
	
	marginElement := BlElement new.
	marginElement margin: self client margin negated.
	marginElement background: (Color red alpha: 0.5).
	marginElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	marginElement wantsMouse: false.
	marginElement effect: (BlClipOutInsetsEffect new insets: (self client margin)).

	paddingElement := BlElement new.
	paddingElement background: (Color blue alpha: 0.4).
	paddingElement border: (BlBorder paint: Color blue width: ((self client extent / 100.0) min max: self client border width)).
	paddingElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	paddingElement wantsMouse: false.
	paddingElement effect: (BlClipOutInsetsEffect new insets: (self client padding)).

	extentTextElement := BlTextElement new.
	extentTextElement padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5).
	extentTextElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	extentTextElement text: (self client extent asString asRopedText).
	
	extentElement := BlScalableElement new.
	extentElement maxScale: 1.5.
	extentElement margin: self client padding.
	extentElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	extentElement contentElement: extentTextElement.

	self addChild: marginElement.
	self addChild: paddingElement.
	self addChild: extentElement.
	
	hasInformation := true
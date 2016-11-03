as yet unclassified
boxShadow: anBlArrayValue
	| arr |
	anBlArrayValue ifNil: [ ^ self styleable effect: BlNullEffect new ].
	arr := anBlArrayValue value.
	self styleable effect: (BlDropShadowEffect new
				offset: arr first value @ arr second value;
				width: (arr at: 3) value;
				color: (arr at: 4) value;
				yourself)
accessing
transite: aValue on: aTarget property: aSymbol
	| anim |
	anim := self animation
		duration: self transition duration;
		delay: self transition delay;
		from: (self property: aSymbol of: aTarget);
		to: aValue;
		easing:(BlEasing perform:self transition timingFunction);
		onStepDo: [ :v | self apply: v on: aTarget property: aSymbol ].
	anim start.
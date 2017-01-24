examples
exampleGallery
	| space list container header headerText |
	space := BlSpace new
		extent: 400 @ 650;
		title: 'Gallery'.

	container := BlElement new
		layout: BlFrameLayout new;
		background: Color veryDarkGray;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			"will take 100% of the parent"
			c linear weight: 1 ];
		yourself.	

	header := BlElement new
		layout: BlLinearLayout vertical;
		"effect: (BlBlurBelowEffect radius: 4);"
		background: (Color black alpha: 0.6);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c frame vertical alignTop.
			c padding: (BlInsets top: 15 right: 0 bottom: 15 left: 0) ];
		yourself.

	headerText := BlTextElement new
		text: ((SpText fromString: 'bloc gallery')
			attributes: { 
				SpTextForegroundAttribute paint: (Color white alpha: 0.8).
				SpFontSizeAttribute size: 20.
				SpFontWeightAttribute weight: 50.
				SpFontFamilyAttribute named: 'Helvetica Neue'
			};
			yourself);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignCenter.
			c linear vertical alignCenter ];
		yourself.
		
	header addChild: headerText.
	
	list := BlInfiniteExampleGalleryListElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	container addChildren: { list . header }.
	space root addChild: container.
	space root background: Color veryVeryDarkGray.
	space root layout: BlLinearLayout horizontal.
	space root layout weightSum: 1.
"	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show
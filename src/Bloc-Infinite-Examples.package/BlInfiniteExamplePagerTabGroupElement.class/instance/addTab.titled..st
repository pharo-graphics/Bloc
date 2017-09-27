adding
addTab: anElement titled: aString
	| tabLabel |
	
	tabLabel := self newTabLabel.
	tabLabel text: (BrRopedText string: aString).
	tabLabel
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent |
			labelsElement childrenDo: [ :aLabel | aLabel background: BlBackground transparent ].
			anEvent currentTarget background: Color veryVeryLightGray.
			contentElement removeChildren.
			contentElement addChild: anElement ].
	
	labelsElement addChild: tabLabel.
	
	contentElement hasChildren
		ifFalse: [
			contentElement addChild: anElement.
			tabLabel background: Color veryVeryLightGray. ]
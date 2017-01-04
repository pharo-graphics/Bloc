as yet unclassified
createBottomEl
	^ BlMobileSubElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxBottomHeight ];
		addChild: BlMobileHomeButton new;
		yourself
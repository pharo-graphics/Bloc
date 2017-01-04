as yet unclassified
createScreenEl
	^ BlMobileSubElement new
		layout:BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxScreenHeight ];
		padding: (BlInsets
			left: BlMobilePhone pxScreenMargin
			right: BlMobilePhone pxScreenMargin);
		addChild: BlMobileSoftware new;
		yourself
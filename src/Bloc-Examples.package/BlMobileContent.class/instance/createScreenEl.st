as yet unclassified
createScreenEl
	^ BlMobileSubElement new
		layout:BlLinearLayout vertical;
		height: BlMobilePhone pxScreenHeight;
		constraintsDo: [ :c | c horizontal matchParent.];
		 padding: (BlInsets
				left: BlMobilePhone pxScreenMargin
				right: BlMobilePhone pxScreenMargin);
		addChild: BlMobileSoftware new;
		yourself
as yet unclassified
createTopEl
	^ BlMobileSubElement new
		layout: BlLinearLayout vertical;
		padding: (BlInsets top:  BlMobilePhone pxCameraTopMargin);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxTopHeight ];
		addChild: BlMobileCamera new;
		addChild: BlMobileSpeaker new;
		yourself
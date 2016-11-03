as yet unclassified
createTopEl
	^ BlMobileSubElement new
		layout: BlLinearLayout vertical;
		height: BlMobilePhone pxTopHeight;
		padding: (BlInsets top:  BlMobilePhone pxCameraTopMargin);
		constraintsDo: [ :c| c horizontal matchParent];
		addChild: BlMobileCamera new;
		addChild: BlMobileSpeaker new;
		yourself
as yet unclassified
activateOn: aSpace
	self images ifNil: [ ^ self ].
	self createAnimation
		onStepDo: [ self updateNextImageOn: aSpace ];
		start
styling
style: aBrText

	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self privateStyle: aBrText
styling
styleInBackgroundProcess: aBrText
	
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	text := aBrText.

	self monitor critical: [
		backgroundProcess := [ self privateStyle: text ] forkAt: Processor userBackgroundPriority ]
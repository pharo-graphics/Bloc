styling
styleInBackgroundProcess: aBrText
	
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self monitor critical: [
		text := aBrText.
		backgroundProcess := [
			| styledText |
			styledText := self privateStyle: text.
			self fireEvent: (BrTextStyledEvent new text: styledText)
		 ] forkAt: Processor userBackgroundPriority ]
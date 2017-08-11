styling
styleInBackgroundProcessNow: aBrText
	
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	self monitor critical: [
		backgroundProcess := [
			| styledText |
			text := aBrText unstyle.
			styledText := self privateStyle: text.
			self fireEvent: (BrTextStyledEvent new text: styledText)
		 ] forkAt: Processor userBackgroundPriority ]
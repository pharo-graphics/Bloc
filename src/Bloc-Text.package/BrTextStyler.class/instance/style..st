styling
style: aBrText
	| styledText |
	self terminateBackgroundStylingProcess.
	
	stylingEnabled
		ifFalse: [ ^ self ].

	styledText := self privateStyle: aBrText unstyle.
	self fireEvent: (BrTextStyledEvent new text: styledText).
	^ styledText
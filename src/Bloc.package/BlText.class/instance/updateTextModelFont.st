private
updateTextModelFont
	self font ifNil: [ ^ self ].
	(textModel startPosition selectTo: textModel endPosition)
		applyAttribute: (TxFontAttribute with: self font).
	layoutView resetLayout.
	
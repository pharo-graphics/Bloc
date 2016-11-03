private
updateTextModelFill
	self fill ifNil:[^ self].
	(textModel startPosition selectTo: textModel endPosition)
		applyAttribute: (TxForeColorAttribute with: self fill color)
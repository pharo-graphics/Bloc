accessing
text: aString
	textModel initializeWith: (SpRope fromCollection: aString).
	self updateTextModel.
	textModel attributes: { wrapAttribute } from: 1 to: textModel size.
	self computeExtent.
	self invalidate.
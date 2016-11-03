accessing
text: aString
	
	textModel initializeWith: (Rope fromCollection: aString).
	self updateTextModel.
	layoutView := SpartaTextLayout rope: textModel rope.
	layoutView maxWidth: self wrappingWidth.
	textModel attributes: { wrapAttribute } from: 1 to: textModel size.
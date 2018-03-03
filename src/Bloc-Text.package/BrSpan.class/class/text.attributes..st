instance creation
text: aBrText attributes: theAttributes
	^ self basicNew
		initialize;
		text: aBrText
		attributes: theAttributes;
		yourself
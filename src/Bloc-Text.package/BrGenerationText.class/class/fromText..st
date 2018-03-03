instance creation
fromText: aBrText
	^ self basicNew
		initialize;
		initialize: aBrText copy
		with: aBrText generation
instance creation
fromText: aBrText
	^ self new
		initialize: aBrText copy
		with: aBrText generation
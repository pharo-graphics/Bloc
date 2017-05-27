instance creation
newInsetElement
	^ BlTextElement new
		text: (self insetTextFor: 0);
		yourself
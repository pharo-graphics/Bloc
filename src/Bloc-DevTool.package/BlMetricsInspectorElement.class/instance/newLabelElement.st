instance creation
newLabelElement
	^ BlTextElement new
		text: (self labelTextFor: '');
		yourself
instance creation
createMeasurer
	^ self defaultMeasurer
		maxWidth: maxWidth;
		maxHeight: maxHeight;
		text: self text;
		yourself
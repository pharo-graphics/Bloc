instance creation
asElement
	^ BlElement new
		geometry: self;
		background: Color black;
		size: self extent
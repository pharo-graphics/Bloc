instance creation
asElement
	^ BlElement new
		size: self extent;
		background: Color black;
		geometry: self
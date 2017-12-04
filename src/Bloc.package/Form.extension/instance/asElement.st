*Bloc
asElement
	^ BlElement new
		size: self extent;
		background: (BlBackground image: self);
		yourself
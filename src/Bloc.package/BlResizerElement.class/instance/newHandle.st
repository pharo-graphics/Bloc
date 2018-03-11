instance creation
newHandle
	^ BlElement new
		opacity: 0.5;
		background: (Color white);
		border: (BlBorder paint: Color gray width: 1);
		size: 6@6
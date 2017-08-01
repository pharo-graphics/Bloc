installation
onInstalledIn: anElement
	super onInstalledIn: anElement.

	selection := BlElement new
		background: (Color blue alpha: 0.1);
		border: (BlBorder builder paint: (Color blue alpha: 0.7); width: 2; build);
		yourself
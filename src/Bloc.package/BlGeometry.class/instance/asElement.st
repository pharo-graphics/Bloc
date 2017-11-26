converting
asElement
	"Create an appropriate element with me as its geometry.
	By default create an instance of the basic BlElement simply setting its
	geometry to me. Subclasses may be converted to more specific elements"
	<return: #BlElement>

	^ BlElement new
		size: self extent;
		background: (Color gray alpha: 0.4);
		border: (BlBorder builder paint: Color gray; width: 2; build);
		geometry: self
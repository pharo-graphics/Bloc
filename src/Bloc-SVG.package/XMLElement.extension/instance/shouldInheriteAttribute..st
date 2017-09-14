*Bloc-SVG
shouldInheriteAttribute: key
	"Note that the 'transform' attribute will still be inherited but through a special way."

	^ ({'transform' . 'display' . 'x' . 'y' . 'height' . 'width' . 'id' . 'opacity'} includes: key) not
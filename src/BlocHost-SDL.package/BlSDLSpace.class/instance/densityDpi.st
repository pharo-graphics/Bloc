host space - accessing
densityDpi
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	| anIndex |
	
	anIndex := self sdlWindow getDisplayIndex.
	anIndex < 0
		"There is no display, guess dpi"
		ifTrue: [ ^ 96.0 ].
	
	^ 96.0
	
	"SDL does not support DPI yet"
	
	"aDDPI := ByteArray new: ExternalType float byteSize.
	aHDPI := ByteArray new: ExternalType float byteSize.
	aVDPI := ByteArray new: ExternalType float byteSize.
	
	sdlWindow getDisplay: anIndex ddpi: aDDPI hdpi: aHDPI vdpi: aVDPI.
	
	^ aDDPI signedLongAt: 1"
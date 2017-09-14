properties
fillPropertiesFrom: attributes on: aBlElement
	|backgroundBuilder|
	attributes at:'fill' ifPresent:[		
		backgroundBuilder := BlBackgroundBuilder new.
		backgroundBuilder paint: (self paintFrom: (attributes at:'fill') on: aBlElement).
		attributes at:'fill-opacity' ifPresent: [ backgroundBuilder opacity: (attributes at:'fill-opacity') asNumber ].
		
		aBlElement background: backgroundBuilder build.
	]
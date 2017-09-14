properties
strokePropertiesFrom: attributes on: aBlElement
	|borderBuilder dashArray|
	attributes at:'stroke' ifPresent:[
		borderBuilder := BlBorderBuilder new.
		borderBuilder paint: (self paintFrom:(attributes at:'stroke') on: aBlElement).
		attributes at:'stroke-width'
			ifPresent: [ borderBuilder width: (attributes at:'stroke-width') asNumber ].
		attributes at:'stroke-opacity'
			ifPresent: [ borderBuilder opacity: (attributes at:'stroke-opacity') asNumber ].
			
		attributes at:'stroke-linecap'
			ifPresent: [ borderBuilder lineCap: (BlStrokeLineCap perform: (attributes at:'stroke-linecap') asSymbol) ].
		attributes at:'stroke-linejoin'
			ifPresent: [ borderBuilder lineJoin: (BlStrokeLineJoin perform: (attributes at:'stroke-linejoin') asSymbol) ].
		attributes at:'stroke-miterlimit'
			ifPresent: [ borderBuilder miterLimit: (attributes at:'stroke-miterlimit') asNumber ].
			
		attributes at:'stroke-dasharray' ifPresent: [
			dashArray := ((attributes at:'stroke-dasharray') substrings: {Character space. $,}) collect: [:value | value asNumber].
			borderBuilder dashArray: dashArray ].
		attributes at:'stroke-dashoffset'
			ifPresent: [ borderBuilder dashOffset: (attributes at:'stroke-dashoffset') asNumber ].
		
		aBlElement border: borderBuilder build.
	]
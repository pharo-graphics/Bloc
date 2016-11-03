copy
copyWithWidth: aWidth
	^ self class basicNew
		initialize;
		paint: paint
			style: style
			radii: cornerRadii
			width: (aWidth ifNil:[0]);
		yourself
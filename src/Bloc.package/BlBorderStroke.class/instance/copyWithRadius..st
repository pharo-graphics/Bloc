copy
copyWithRadius: aRadius
	^ self class basicNew
		initialize;
		paint: paint
			style: style
			radii: (aRadius ifNil: [ BlCornerRadii empty ] ifNotNil: [ BlCornerRadii radius: aRadius ])
			width: width;
		yourself
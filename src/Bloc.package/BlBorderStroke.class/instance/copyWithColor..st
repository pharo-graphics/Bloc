copy
copyWithColor: aColor
	^ self class basicNew
		initialize;
		paint: aColor asBlPaint
			style: style
			radii: cornerRadii
			width: width;
		yourself
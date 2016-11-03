instance creation
color: aColor width: aWNumber radius: aRNumber style: aBorderStrokeStyle
	^ super new
		paint: aColor asBlPaint
			style: (aBorderStrokeStyle ifNil: [ BlBorderStrokeStyle SOLID ])
			radii: (aRNumber ifNil: [ BlCornerRadii empty ] ifNotNil: [ BlCornerRadii radius: aRNumber ])
			width: (aWNumber ifNil:[0]);
		yourself
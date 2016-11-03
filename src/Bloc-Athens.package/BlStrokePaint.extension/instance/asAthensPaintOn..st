*Bloc-Athens
asAthensPaintOn: aCanvas
	^ paintCache ifNil: [paintCache :=  ((aCanvas surface createStrokePaintFor: (self paint asAthensPaintOn: aCanvas))
		width: self width;
		perform: self joinStyle;
		perform: self lineStyle capStyle;
		dashes: self lineStyle dashes offset: self lineStyle dashesOffset;
		yourself)].
	
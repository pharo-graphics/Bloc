properties
paintFrom: aString on: aBlElement
	^ (self definitions at: ((aString withoutPrefix: 'url(#') withoutSuffix: ')')
		ifPresent: [ :aBlPaint | aBlPaint veryDeepCopy ]
		ifAbsent: [ BlColorPaint color: (SvgColor fromString: aString) ])
	adaptedToElement: aBlElement
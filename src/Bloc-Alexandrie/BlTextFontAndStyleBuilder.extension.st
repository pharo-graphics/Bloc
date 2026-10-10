Extension { #name : #BlTextFontAndStyleBuilder }

{ #category : #'*Bloc-Alexandrie' }
BlTextFontAndStyleBuilder >> aeCairoScaledFontOn: aeCanvas [

	^ aeCanvas
		scaledFontForFamily: (self hasCustomFamilyName
			ifTrue: [ self resolvedFontFamilyName ]
			ifFalse: [ BlFont defaultFamilyName ])
		size: (self hasCustomFontSize
			ifTrue: [ self resolvedFontSize value ]
			ifFalse: [ BlFont defaultFontSize ])
		slant: (self hasCustomFontSlant
			ifTrue: [ BAFontConverter uniqueInstance aeSlantAt: self fontSlant ]
			ifFalse: [ AeFontSlant normal ])
		weight: (self hasCustomFontWeight
			ifTrue: [ BAFontConverter uniqueInstance aeWeightAt: self fontWeight ]
			ifFalse: [ AeFontWeight normal ])
		stretch: (self hasCustomFontStretch
			ifTrue: [ BAFontConverter uniqueInstance aeStretchAt: self fontStretch ]
			ifFalse: [ AeFontStretch normal ])
]

accessing
named: aColorName
	^ SVGColorRegistry  at: aColorName asSymbol ifAbsent: nil 
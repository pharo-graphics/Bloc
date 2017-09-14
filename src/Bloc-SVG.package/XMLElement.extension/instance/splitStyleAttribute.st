*Bloc-SVG
splitStyleAttribute
	self attributeAt:'style' ifAbsent:[^self].
	
	((self attributeAt:'style') substrings: ';') do: [:keyAndVal |
			self attributeAt: (keyAndVal copyUpTo: $:) trimBoth put: (keyAndVal copyAfter: $:) trimBoth].

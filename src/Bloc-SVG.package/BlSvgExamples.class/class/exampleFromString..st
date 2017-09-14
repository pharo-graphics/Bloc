private
exampleFromString:aString
	| aSpace |
	
	lastConverted := BlSvgConverter convertFromString: aString.

	aSpace := BlSpace new
		extent: lastConverted extent;
		title: 'Bloc-SVG Conversion Example'.
	aSpace root addChild: lastConverted.
	aSpace show
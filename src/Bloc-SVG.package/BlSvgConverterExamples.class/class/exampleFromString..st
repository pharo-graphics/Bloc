private
exampleFromString:aString
	|space|
	lastConverted := BlSvgConverter convertFromString: aString.

	space := BlSpace new
		root:lastConverted;
		extent: lastConverted extent;
		title: 'Bloc-SVG Conversion Example'
		yourself.
	space show.
attributes
emphasisAttribute: anEmphasisAsSymbol
	"Create and return a text emphasis attribute for a given emphasis.
	anEmphasisAsSymbol can be either #bold #italic #oblique or #normal"
	<return: #BrTextAttribute>
	
	anEmphasisAsSymbol = #bold
		ifTrue: [ ^ BrFontWeightAttribute bold ].
	
	anEmphasisAsSymbol = #italic
		ifTrue: [ ^ BrFontEmphasisAttribute italic ].
		
	anEmphasisAsSymbol = #oblique
		ifTrue: [ ^ BrFontEmphasisAttribute oblique ].
		
	anEmphasisAsSymbol = #normal
		ifTrue: [ ^ BrFontEmphasisAttribute normal ].
	
	anEmphasisAsSymbol = #light
		ifTrue: [ ^ BrFontWeightAttribute light ].

	self error: 'Unknown emphasis: ', anEmphasisAsSymbol asString
private
attributeArrayForColor: aColorOrNil emphasis: anEmphasisArray
	"Return a collection of text or font attributes for given color (or nil)
	and array of requested emphasis styles (#bold, #italic, #oblique or #normal)"
	<return: #Array of: #BrTextAttribute>

	^ Array streamContents: [ :aStream |
		aColorOrNil ifNotNil: [ :aColor |
			aStream nextPut: (self foregroundAttribute: aColor) ].
		anEmphasisArray do: [ :anEmphasis | aStream nextPut: (self emphasisAttribute: anEmphasis) ] ]
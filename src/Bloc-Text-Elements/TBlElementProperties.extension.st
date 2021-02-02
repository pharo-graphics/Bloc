Extension { #name : #TBlElementProperties }

{ #category : #'*Bloc-Text-Elements' }
TBlElementProperties >> fontSize: aBlElementPropertyLength [
	self addProperty: (BlElementFontSizeProperty new fontSize: aBlElementPropertyLength)
]

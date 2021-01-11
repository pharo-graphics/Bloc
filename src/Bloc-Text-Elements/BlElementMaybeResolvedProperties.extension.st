Extension { #name : #BlElementMaybeResolvedProperties }

{ #category : #'*Bloc-Text-Elements' }
BlElementMaybeResolvedProperties >> fontSize [
	<return: #BlElementFontSizeProperty>

	^ (self
		propertyAt: BlElementFontSizeProperty
		ifNone: [ BlElementFontSizeProperty default ]) fontSize
]

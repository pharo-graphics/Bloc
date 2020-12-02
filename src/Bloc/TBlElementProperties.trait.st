Trait {
	#name : #TBlElementProperties,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #adding }
TBlElementProperties >> addProperty: aBlElementProperty [
	self explicitRequirement
]

{ #category : #'api - properties' }
TBlElementProperties >> background: aPaint [
	self addProperty: (BlElementBackgroundProperty new background: aPaint)
]

{ #category : #'api - properties' }
TBlElementProperties >> border: aBlBorder [
	self addProperty: (BlElementBorderProperty new border: aBlBorder)
]

{ #category : #'api - properties' }
TBlElementProperties >> fontSize: aBlElementPropertyLength [
	self addProperty: (BlElementFontSizeProperty new fontSize: aBlElementPropertyLength)
]

{ #category : #'api - properties' }
TBlElementProperties >> fontSizeEm: aNumber [
	self fontSize: (BlElementPropertyLength em: aNumber)
]

{ #category : #'api - properties' }
TBlElementProperties >> fontSizePt: aNumber [
	self fontSize: (BlElementPropertyLength pt: aNumber)
]

{ #category : #'api - properties' }
TBlElementProperties >> fontSizeRem: aNumber [
	self fontSize: (BlElementPropertyLength rem: aNumber)
]

{ #category : #'api - properties' }
TBlElementProperties >> foreground: aPaint [
	self addProperty: (BlElementForegroundProperty new foreground: aPaint)
]

Trait {
	#name : #TBlFont,
	#instVars : [
		'fontFamilyName',
		'fontSize',
		'fontStretch',
		'fontStyle',
		'fontWeight'
	],
	#category : #'Bloc-Text-Font'
}

{ #category : #private }
TBlFont >> privateFontFamilyName [
	<return: #String>

	^ fontFamilyName
]

{ #category : #private }
TBlFont >> privateFontFamilyName: aString [
	fontFamilyName := aString
]

{ #category : #private }
TBlFont >> privateFontSize [
	<return: #BlValueWithUnit>

	^ fontSize
]

{ #category : #private }
TBlFont >> privateFontSize: aBlValueWithUnit [
	fontSize := aBlValueWithUnit
]

{ #category : #private }
TBlFont >> privateFontStretch [
	<return: #BlFontStretch>

	^ fontStretch
]

{ #category : #private }
TBlFont >> privateFontStretch: aBlFontStretch [
	fontStretch := aBlFontStretch
]

{ #category : #private }
TBlFont >> privateFontStyle [
	<return: #BlFontStyle>

	^ fontStyle
]

{ #category : #private }
TBlFont >> privateFontStyle: aBlFontStyle [
	fontStyle := aBlFontStyle
]

{ #category : #private }
TBlFont >> privateFontWeight [
	<return: #BlFontWeight>

	^ fontWeight
]

{ #category : #private }
TBlFont >> privateFontWeight: aBlFontWeight [
	fontWeight := aBlFontWeight
]

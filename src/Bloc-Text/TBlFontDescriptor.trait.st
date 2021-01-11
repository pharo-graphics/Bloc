Trait {
	#name : #TBlFontDescriptor,
	#category : #'Bloc-Text-Font'
}

{ #category : #'font - name' }
TBlFontDescriptor >> familyName [
	<return: #String>

	^ self font privateFontFamilyName
]

{ #category : #'font - name' }
TBlFontDescriptor >> familyName: aString [
	<return: #String>

	self font privateFontFamilyName: aString
]

{ #category : #accessing }
TBlFontDescriptor >> font [
	<return: #TBlFont>

	^ self explicitRequirement
]

{ #category : #'font - size' }
TBlFontDescriptor >> fontSize [
	<return: #BlValueWithUnit>
	
	^ self font privateFontSize
]

{ #category : #'font - size' }
TBlFontDescriptor >> fontSize: aBlValueWithUnitOrNumber [
	self font privateFontSize: (aBlValueWithUnitOrNumber isNumber
		ifTrue: [ BlValueWithUnit pt: aBlValueWithUnitOrNumber ]
		ifFalse: [ aBlValueWithUnitOrNumber ])
]

{ #category : #'font - slant' }
TBlFontDescriptor >> fontSlant [
	<return: #BlFontSlant>

	^ self font privateFontSlant
]

{ #category : #'font - slant' }
TBlFontDescriptor >> fontSlant: aBlFontSlantOrNumber [
	self font privateFontSlant: (aBlFontSlantOrNumber isNumber
		ifTrue: [ BlFontSlant fromNumber: aBlFontSlantOrNumber ]
		ifFalse: [ aBlFontSlantOrNumber ])
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> fontStretch [
	<return: #BlFontStretch>

	^ self font privateFontStretch
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> fontStretch: aBlFontStretch [
	self font privateFontStretch: aBlFontStretch
]

{ #category : #'font - weight' }
TBlFontDescriptor >> fontWeight [
	<return: #BlFontWeight>

	^ self font privateFontWeight
]

{ #category : #'font - weight' }
TBlFontDescriptor >> fontWeight: aBlFontWeightOrNumber [
	self font privateFontWeight: (aBlFontWeightOrNumber isNumber
		ifTrue: [ BlFontWeight fromNumber: aBlFontWeightOrNumber ]
		ifFalse: [ aBlFontWeightOrNumber ])
]

{ #category : #'font - slant' }
TBlFontDescriptor >> slantItalic [
	self fontSlant: BlFontSlant italic
]

{ #category : #'font - slant' }
TBlFontDescriptor >> slantNormal [
	self fontSlant: BlFontSlant normal
]

{ #category : #'font - slant' }
TBlFontDescriptor >> slantOblique [
	self fontSlant: BlFontSlant oblique
]

{ #category : #'font - slant' }
TBlFontDescriptor >> slantReset [
	self slantNormal
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchCondensed [
	self fontStretch: BlFontStretch condensed
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchExpanded [
	self fontStretch: BlFontStretch expanded
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchExtraCondensed [
	self fontStretch: BlFontStretch extraCondensed
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchExtraExpanded [
	self fontStretch: BlFontStretch extraExpanded
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchNormal [
	self fontStretch: BlFontStretch normal
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchReset [
	self stretchNormal
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchSemiCondensed [
	self fontStretch: BlFontStretch semiCondensed
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchSemiExpanded [
	self fontStretch: BlFontStretch semiExpanded
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchUltraCondensed [
	self fontStretch: BlFontStretch ultraCondensed
]

{ #category : #'font - stretch' }
TBlFontDescriptor >> stretchUltraExpanded [
	self fontStretch: BlFontStretch ultraExpanded
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightBlack [
	self fontWeight: BlFontWeight black
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightBold [
	self fontWeight: BlFontWeight bold
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightExtraBlack [
	self fontWeight: BlFontWeight extraBlack
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightExtraBold [
	self fontWeight: BlFontWeight extraBold
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightExtraLight [
	self fontWeight: BlFontWeight extraLight
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightLight [
	self fontWeight: BlFontWeight light
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightMedium [
	self fontWeight: BlFontWeight medium
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightNormal [
	self fontWeight: BlFontWeight normal
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightReset [
	self weightNormal
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightSemiBold [
	self fontWeight: BlFontWeight semiBold
]

{ #category : #'font - weight' }
TBlFontDescriptor >> weightThin [
	self fontWeight: BlFontWeight thin
]

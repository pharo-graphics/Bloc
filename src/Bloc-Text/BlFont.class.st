Class {
	#name : #BlFont,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#category : 'Bloc-Text-Font'
}

{ #category : #defaults }
BlFont class >> defaultFamilyName [
	^ 'Source Sans Pro'
]

{ #category : #defaults }
BlFont class >> defaultFontSize [
	"14pt"

	^ 14
]

{ #category : #performing }
BlFont >> applyOnText: aBlText [
	aBlText
		fontName: self familyName;
		fontSize: self fontSize value;
		weight: self fontWeight value;
		perform: self fontSlant name
]

{ #category : #accessing }
BlFont >> fontPropertiesTarget [
	<return: #TBlFont>

	^ self
]

{ #category : #initialization }
BlFont >> initialize [
	super initialize.
	
	self familyName: self class defaultFamilyName.
	self fontSize: self class defaultFontSize.
	self slantReset.
	self stretchReset.
	self weightReset.
]

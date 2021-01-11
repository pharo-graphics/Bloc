Class {
	#name : #BlFont,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#category : #'Bloc-Text-Font'
}

{ #category : #defaults }
BlFont class >> defaultFamilyName [
	^ 'Helvetica Neue'
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
BlFont >> font [
	<return: #TBlFont>

	^ self
]

{ #category : #'gt-extension' }
BlFont >> gtPreviewFor: aView [
	<gtView>
	
	^ aView text
		title: 'Preview';
		priority: 5;
		text: [
			| aText |
			aText := 'ABCDEFGHIJKLM
NOPQRSTUVWXYZ
abcdefghijklm
nopqrstuvwxyz
1234567890' asRopedText.
			self applyOnText: aText.
			aText ]
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

"
I am a unified entrance point for text style attributes. My goal is to let users add text attributes without directly referencing attribute classes.

As a trait I am used in different parts of the system, thus by adding extension methods to me developers can add support of their custom attributes everywhere.
"
Trait {
	#name : #TBlTextStyleable,
	#category : 'Bloc-Text-Text-Support'
}

{ #category : #accessing }
TBlTextStyleable >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ self explicitRequirement
]

{ #category : #'api - text style' }
TBlTextStyleable >> background: aPaint [
	self attributesBuilder attribute: (BlTextBackgroundAttribute paint: aPaint)
]

{ #category : #'api - text weight' }
TBlTextStyleable >> bold [
	self attributesBuilder attribute: BlFontWeightAttribute bold
]

{ #category : #'api - text font' }
TBlTextStyleable >> fontName: aString [
	self attributesBuilder attribute: (BlFontFamilyAttribute named: aString)
]

{ #category : #'api - text font' }
TBlTextStyleable >> fontSize: aNumber [
	self attributesBuilder attribute: (BlFontSizeAttribute size: aNumber)
]

{ #category : #'api - text style' }
TBlTextStyleable >> foreground: aBlPaint [
	self attributesBuilder attribute: (BlTextForegroundAttribute paint: aBlPaint)
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> italic [
	self attributesBuilder attribute: BlFontEmphasisAttribute italic
]

{ #category : #'api - text weight' }
TBlTextStyleable >> light [
	self attributesBuilder attribute: BlFontWeightAttribute light
]

{ #category : #'api - text font' }
TBlTextStyleable >> monospace [
	self attributesBuilder attribute: (BlFontGenericFamilyAttribute monospace)
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> normal [
	self attributesBuilder attribute: BlFontEmphasisAttribute normal
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> oblique [
	self attributesBuilder attribute: BlFontEmphasisAttribute oblique
]

{ #category : #'api - text weight' }
TBlTextStyleable >> regular [
	self attributesBuilder attribute: BlFontWeightAttribute normal
]

{ #category : #'api - text style' }
TBlTextStyleable >> spacing: aNumber [
	self attributesBuilder attribute: (BlTextSpacingAttribute spacing: aNumber)
]

{ #category : #'api - text weight' }
TBlTextStyleable >> thin [
	self attributesBuilder attribute: BlFontWeightAttribute thin
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underline [
	"Set the default underline"

	self underlineDo: [ :anAttribute | ]
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underlineDo: aBlock [
	| anAttribute |
	
	anAttribute := BlTextUnderlineAttribute new.
	aBlock value: anAttribute.
	self attributesBuilder attribute: anAttribute
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underlinePaint: aPaint width: aNumber [

	self underlineDo: [ :anAttribute |
		anAttribute
			paint: aPaint;
			width: aNumber ]
]

{ #category : #'api - text weight' }
TBlTextStyleable >> weight: aNumber [
	self attributesBuilder attribute: (BlFontWeightAttribute weight: aNumber)
]

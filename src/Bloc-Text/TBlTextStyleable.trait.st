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
	self attributesBuilder attribute: (BrTextBackgroundAttribute paint: aPaint)
]

{ #category : #'api - text weight' }
TBlTextStyleable >> bold [
	self attributesBuilder attribute: BrFontWeightAttribute bold
]

{ #category : #'api - text font' }
TBlTextStyleable >> fontName: aString [
	self attributesBuilder attribute: (BrFontFamilyAttribute named: aString)
]

{ #category : #'api - text font' }
TBlTextStyleable >> fontSize: aNumber [
	self attributesBuilder attribute: (BrFontSizeAttribute size: aNumber)
]

{ #category : #'api - text style' }
TBlTextStyleable >> foreground: aBlPaint [
	self attributesBuilder attribute: (BrTextForegroundAttribute paint: aBlPaint)
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> italic [
	self attributesBuilder attribute: BrFontEmphasisAttribute italic
]

{ #category : #'api - text weight' }
TBlTextStyleable >> light [
	self attributesBuilder attribute: BrFontWeightAttribute light
]

{ #category : #'api - text font' }
TBlTextStyleable >> monospace [
	self attributesBuilder attribute: (BrFontGenericFamilyAttribute monospace)
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> normal [
	self attributesBuilder attribute: BrFontEmphasisAttribute normal
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> oblique [
	self attributesBuilder attribute: BrFontEmphasisAttribute oblique
]

{ #category : #'api - text weight' }
TBlTextStyleable >> regular [
	self attributesBuilder attribute: BrFontWeightAttribute normal
]

{ #category : #'api - text weight' }
TBlTextStyleable >> thin [
	self attributesBuilder attribute: BrFontWeightAttribute thin
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underline [
	self attributesBuilder attribute: BrTextUnderlineAttribute new
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underlinePaint: aPaint [
	self attributesBuilder attribute: (BrTextUnderlineAttribute new paint: aPaint)
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> underlinePaint: aPaint width: aNumber [
	self attributesBuilder attribute: (
		BrTextUnderlineAttribute new 
			paint: aPaint;
			width: aNumber)
]

{ #category : #'api - text weight' }
TBlTextStyleable >> weight: aNumber [
	self attributesBuilder attribute: (BrFontWeightAttribute weight: aNumber)
]

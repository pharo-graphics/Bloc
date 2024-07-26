"
I am a unified entrance point for text style attributes. My goal is to let users add text attributes without directly referencing attribute classes.

As a trait I am used in different parts of the system, thus by adding extension methods to me developers can add support of their custom attributes everywhere.
"
Trait {
	#name : #TBlTextStyleable,
	#category : #'Bloc-Text-Text-Support'
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
TBlTextStyleable >> black [
	self attributesBuilder attribute: BlFontWeightAttribute black
]

{ #category : #'api - text weight' }
TBlTextStyleable >> bold [
	self attributesBuilder attribute: BlFontWeightAttribute bold
]

{ #category : #'api - text style' }
TBlTextStyleable >> border: aBlBorder [

	self border: aBlBorder above: false
]

{ #category : #'api - text style' }
TBlTextStyleable >> border: aBlBorder above: aBoolean [

	self attributesBuilder attribute:
		(BlTextBorderAttribute border: aBlBorder above: aBoolean)
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> decorationDo: aBlock [
	| anAttribute |
	
	anAttribute := BlTextDecorationAttribute new.
	aBlock value: anAttribute.
	self attributesBuilder attribute: anAttribute
]

{ #category : #'api - text font' }
TBlTextStyleable >> defaultFontName: aString [
	self attributesBuilder attribute: (BlFontFamilyDefaultAttribute named: aString)
]

{ #category : #'api - text font' }
TBlTextStyleable >> defaultFontSize: aNumber [
	self attributesBuilder attribute: (BlFontSizeDefaultAttribute size: aNumber)
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

{ #category : #'api - text orientation' }
TBlTextStyleable >> horizontal [
	
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> italic [
	self attributesBuilder attribute: BlFontEmphasisAttribute italic
]

{ #category : #'api - text weight' }
TBlTextStyleable >> light [
	self attributesBuilder attribute: BlFontWeightAttribute light
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> lineThroughDo: aBlock [
	self decorationDo: [ :aBlTextDecorationAttribute | aBlock value: aBlTextDecorationAttribute lineThrough ]
]

{ #category : #'api - text weight' }
TBlTextStyleable >> medium [
	self attributesBuilder attribute: BlFontWeightAttribute medium
]

{ #category : #'api - text style' }
TBlTextStyleable >> monospace [
	
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> normal [
	self attributesBuilder attribute: BlFontEmphasisAttribute normal
]

{ #category : #'api - text emphasis' }
TBlTextStyleable >> oblique [
	self attributesBuilder attribute: BlFontEmphasisAttribute oblique
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> overlineDo: aBlock [
	self decorationDo: [ :aBlTextDecorationAttribute | aBlock value: aBlTextDecorationAttribute overline ]
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

{ #category : #'api - text decoration' }
TBlTextStyleable >> underline [
	"Set the default underline of black color and thickness 1"

	self underlineDo: [ :aBlTextDecorationAttribute | ]
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> underlineColor: aColor [
	self underlineDo: [ :aBlTextDecorationAttribute | aBlTextDecorationAttribute color: aColor ]
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> underlineColor: aColor thickness: aNumber [
	self underlineDo: [ :aBlTextDecorationAttribute |
		aBlTextDecorationAttribute
			color: aColor;
			thickness: aNumber ]
]

{ #category : #'api - text decoration' }
TBlTextStyleable >> underlineDo: aBlock [
	self decorationDo: [ :aBlTextDecorationAttribute | aBlock value: aBlTextDecorationAttribute underline ]
]

{ #category : #'api - text orientation' }
TBlTextStyleable >> vertical [
	
]

{ #category : #'api - text weight' }
TBlTextStyleable >> weight: aNumber [
	self attributesBuilder attribute: (BlFontWeightAttribute weight: aNumber)
]

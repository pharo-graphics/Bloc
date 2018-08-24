Class {
	#name : #BlTextStyler,
	#superclass : #BlElementStyler,
	#category : 'Bloc-Style-Styler'
}

{ #category : #'as yet unclassified' }
BlTextStyler class >> styleProperties [
	^ super styleProperties , #(#fontSize #color #fontFamily)
]

{ #category : #'as yet unclassified' }
BlTextStyler >> color [
	^ self backgroundColor asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlTextStyler >> color: anBlValue [
	self backgroundColor:anBlValue
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontColor [
	^ self color asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontColor: anBlValue [
	self color: anBlValue value
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontFamily [
	self styleable font familyName asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontFamily: anBlValue [
	self styleable
		font: (LogicalFont familyName: (anBlValue value ifNil: [ StandardFonts defaultFont familyName ]) pointSize: self styleable font pointSize)
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontSize [
	self styleable font pointSize asBlPt
]

{ #category : #'as yet unclassified' }
BlTextStyler >> fontSize: anBlValue [
	self styleable
		font: (LogicalFont familyName: self styleable font familyName pointSize: (anBlValue value ifNil: [ StandardFonts defaultFont pointSize ]))
]

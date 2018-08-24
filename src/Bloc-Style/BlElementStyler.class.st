Class {
	#name : #BlElementStyler,
	#superclass : #BlCssStyler,
	#category : 'Bloc-Style-Styler'
}

{ #category : #'as yet unclassified' }
BlElementStyler class >> styleProperties [
	^ #(#backgroundColor #borderRadius #borderColor #borderWidth #boxShadow)
]

{ #category : #'as yet unclassified' }
BlElementStyler >> backgroundColor [
	^ self styleable background fill color asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlElementStyler >> backgroundColor: anBlColorValue [
	anBlColorValue ifNil: [ ^ self styleable background: Color transparent ].
	self styleable background: anBlColorValue value
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderColor [
	^ self styleable border stroke paint color asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderColor: aBlColorValue [
	self styleable border: (BlBorder stroke:
					(self styleable border stroke
						copyWithColor: (aBlColorValue value ifNil: [ Color transparent ])))
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderRadius [
	"self styleable cornerRadius"
	^ 0 asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderRadius: anBlValue [
	self styleable border: (BlBorder stroke:
					(self styleable border stroke copyWithRadius: (anBlValue value ifNil: [ 0 ])))
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderWidth [
	self styleable border stroke width asBlStyleValue.
	
]

{ #category : #'as yet unclassified' }
BlElementStyler >> borderWidth: anBlValue [
	self styleable border: (BlBorder stroke:
					(self styleable border stroke copyWithWidth: (anBlValue value ifNil: [ 0 ])))
]

{ #category : #'as yet unclassified' }
BlElementStyler >> boxShadow [
	^ nil asBlStyleValue
]

{ #category : #'as yet unclassified' }
BlElementStyler >> boxShadow: anBlArrayValue [
	| arr |
	anBlArrayValue ifNil: [ ^ self styleable effect: BlNullEffect new ].
	arr := anBlArrayValue value.
	self styleable effect: (BlDropShadowEffect new
				offset: arr first value @ arr second value;
				width: (arr at: 3) value;
				color: (arr at: 4) value;
				yourself)
]

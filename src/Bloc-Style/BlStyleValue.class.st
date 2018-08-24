Class {
	#name : #BlStyleValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'transition',
		'animation'
	],
	#category : 'Bloc-Style-Value'
}

{ #category : #'as yet unclassified' }
BlStyleValue class >> em: aValue [
	^ BlEmValue value: aValue 
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> ms: aValue [
	^ BlDurationValue value: aValue ms
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> percent: aValue [
	^ BlPercentValue value: aValue percent
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> pt: aValue [
	^ BlPtValue value: aValue 
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> px: aValue [
	^ BlPixelValue value: aValue px
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> rem: aValue [
	^ BlRemValue value: aValue rem
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> s: aValue [
	^ BlDurationValue value: aValue s
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> value: aValue [
	^ self value: aValue transition: nil
]

{ #category : #'as yet unclassified' }
BlStyleValue class >> value: aValue transition: aTransition [
	^ self new
		value: aValue;
		transition: aTransition;
		yourself
]

{ #category : #'as yet unclassified' }
BlStyleValue >> + anObject [
	^ self value + anObject
]

{ #category : #'as yet unclassified' }
BlStyleValue >> = aStyleValue [
	^ self value = aStyleValue value
]

{ #category : #'as yet unclassified' }
BlStyleValue >> @ anObject [
	^ self value @ anObject
]

{ #category : #accessing }
BlStyleValue >> animation [
	^ animation ifNil: [ animation := self defaultAnimation ]
]

{ #category : #accessing }
BlStyleValue >> animation: anObject [
	animation := anObject
]

{ #category : #accessing }
BlStyleValue >> apply: aValue on: aTarget property: aSymbol [
	aTarget perform: aSymbol asMutator with: aValue
]

{ #category : #accessing }
BlStyleValue >> applyOn: aTarget property: aSymbol [
	| valueToApply |
	valueToApply := self computeValueFrom: aTarget property: aSymbol.
	(self transition isNil or: [ self transition duration = 0 ])
		ifTrue: [ self apply: valueToApply on: aTarget property: aSymbol ]
		ifFalse: [ self transite: valueToApply on: aTarget property: aSymbol ]
]

{ #category : #'as yet unclassified' }
BlStyleValue >> asBlStyleValue [
	^ self
]

{ #category : #accessing }
BlStyleValue >> computeValueFrom: aTarget property: aSymbol [
	^ self 
]

{ #category : #accessing }
BlStyleValue >> defaultAnimation [
	^ BlNumberTransition new
]

{ #category : #'as yet unclassified' }
BlStyleValue >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self value
]

{ #category : #'as yet unclassified' }
BlStyleValue >> hasTransition [
	^ self transition isNotNil and: [ self transition duration > 0 ]
]

{ #category : #accessing }
BlStyleValue >> initialize [
	super initialize.

]

{ #category : #accessing }
BlStyleValue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
BlStyleValue >> property: aSymbol of: aTarget [
	^ aTarget styler perform: aSymbol
]

{ #category : #accessing }
BlStyleValue >> transite: aValue on: aTarget property: aSymbol [
	| anim |
	anim := self animation
		duration: self transition duration;
		delay: self transition delay;
		from: (self property: aSymbol of: aTarget);
		to: aValue;
		easing:(BlEasing perform:self transition timingFunction);
		onStepDo: [ :v | self apply: v on: aTarget property: aSymbol ].
	anim start.
]

{ #category : #accessing }
BlStyleValue >> transition [
	^ transition
]

{ #category : #accessing }
BlStyleValue >> transition: anObject [
	transition := anObject
]

{ #category : #accessing }
BlStyleValue >> value [
	^ value
]

{ #category : #accessing }
BlStyleValue >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
BlStyleValue >> valueRelativeTo: aTargetProperty [
	^ self value
]

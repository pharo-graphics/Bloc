Class {
	#name : #BlTextDecorationCompositeType,
	#superclass : #BlTextDecorationType,
	#instVars : [
		'types'
	],
	#category : #'Bloc-Text-Text-Decoration'
}

{ #category : #comparing }
BlTextDecorationCompositeType >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ types = anObject types
]

{ #category : #adding }
BlTextDecorationCompositeType >> addType: aBlTextDecorationType [
	types add: aBlTextDecorationType
]

{ #category : #'gt-extension' }
BlTextDecorationCompositeType >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			| aText |
			aText := self hasTypes
				ifTrue: [ String streamContents: [ :aStream |
					types
						do: [ :eachType | aStream nextPutAll: eachType class label ]
						separatedBy: [ aStream nextPutAll: ' | ' ] ] ]
				ifFalse: [ 'No decoration' ].
			aText asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute decoration type: self ] ]
]

{ #category : #testing }
BlTextDecorationCompositeType >> hasTypes [
	^ types isNotEmpty
]

{ #category : #comparing }
BlTextDecorationCompositeType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ types hash
]

{ #category : #initialization }
BlTextDecorationCompositeType >> initialize [
	super initialize.
	
	types := Set new
]

{ #category : #printing }
BlTextDecorationCompositeType >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Types: ';
		nextPut: ${.
	
	types
		do: [ :eachType | aStream print: eachType ]
		separatedBy: [ aStream nextPutAll: ' | ' ].

	aStream	
		space;
		nextPut: $}
]

{ #category : #printing }
BlTextDecorationCompositeType >> storeOn: aStream [
	aStream
		nextPut: $(.
		
	(self typeCount = 0 or: [ self typeCount = 1 ])
		ifTrue: [ aStream nextPutAll: self class name; space; nextPutAll: #new ].
	
	self typeCount = 1
		ifTrue: [ aStream space; nextPutAll: #addType:; space; store: types anyOne ].
		
	self typeCount > 1
		ifTrue: [
			types
				do: [ :eachType | aStream store: eachType ]
				separatedBy: [ aStream space; nextPutAll: #|; space ] ].
	
	aStream nextPut: $)
]

{ #category : #accessing }
BlTextDecorationCompositeType >> typeCount [
	^ types size
]

{ #category : #accessing }
BlTextDecorationCompositeType >> types [
	^ types
]

{ #category : #enumerating }
BlTextDecorationCompositeType >> typesDo: aBlock [
	self types do: [ :eachType | eachType typesDo: aBlock ]
]

{ #category : #'api - composition' }
BlTextDecorationCompositeType >> withLineThrough [
	self addType: self class lineThrough
]

{ #category : #'api - composition' }
BlTextDecorationCompositeType >> withOverline [
	self addType: self class overline
]

{ #category : #'api - composition' }
BlTextDecorationCompositeType >> withUnderline [
	self addType: self class underline
]

{ #category : #'logical operations' }
BlTextDecorationCompositeType >> | anOtherDecorationType [
	^ self addType: anOtherDecorationType
]

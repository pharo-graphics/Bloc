Class {
	#name : 'BlTextDecoration',
	#superclass : 'Object',
	#instVars : [
		'thickness',
		'color',
		'style',
		'type'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Decoration',
	#package : 'Bloc-Text',
	#tag : 'Text-Decoration'
}

{ #category : 'accessing' }
BlTextDecoration class >> label [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
BlTextDecoration >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ color = anObject color
		and: [ style = anObject style
				and: [ thickness = anObject thickness and: [ type = anObject type ] ] ]
]

{ #category : 'accessing' }
BlTextDecoration >> color [
	^ color
]

{ #category : 'api - decoration' }
BlTextDecoration >> color: aColor [
	color := aColor
]

{ #category : 'api - decoration' }
BlTextDecoration >> dashed [
	self style: BlTextDecorationStyle dashed
]

{ #category : 'api - decoration' }
BlTextDecoration >> dotted [
	self style: BlTextDecorationStyle dotted
]

{ #category : 'api - decoration' }
BlTextDecoration >> double [
	self style: BlTextDecorationStyle double
]

{ #category : 'comparing' }
BlTextDecoration >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ color hash
		bitXor: (style hash bitXor: (thickness hash bitXor: type hash))
]

{ #category : 'initialization' }
BlTextDecoration >> initialize [
	super initialize.
	
	color := Color black.
	style := BlTextDecorationStyle solid.
	type := BlTextDecorationCompositeType new.
	thickness := 1
]

{ #category : 'printing' }
BlTextDecoration >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Decoration';
		space;
		nextPut: ${.
	aStream
		nextPutAll: ' color: ';
		print: color;
		nextPut: $;.
	aStream
		nextPutAll: ' style: ';
		print: style;
		nextPut: $;.
	aStream
		nextPutAll: ' thickness: ';
		print: thickness;
		nextPut: $;.
	aStream
		nextPutAll: ' type: ';
		print: type.
		
	aStream
		space;
		nextPut: $}
]

{ #category : 'api - decoration' }
BlTextDecoration >> solid [
	self style: BlTextDecorationStyle solid
]

{ #category : 'printing' }
BlTextDecoration >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: #new;
		space;
			nextPutAll: #color:;
			space;
			store: self color;
			nextPut: $;;
		space;
			nextPutAll: #style:;
			space;
			store: self style;
			nextPut: $;;
		space;
			nextPutAll: #thickness:;
			space;
			store: self thickness;
			nextPut: $;;
		space;
			nextPutAll: #type:;
			space;
			store: self type;
		nextPut: $)
]

{ #category : 'accessing' }
BlTextDecoration >> style [
	<return: #BlTextDecorationStyle>

	^ style
]

{ #category : 'accessing' }
BlTextDecoration >> style: aBlTextDecorationStyle [
	style := aBlTextDecorationStyle
]

{ #category : 'accessing' }
BlTextDecoration >> thickness [
	<return: #Number>

	^ thickness
]

{ #category : 'api - decoration' }
BlTextDecoration >> thickness: aNumber [

	self 
		assert: [ aNumber >= 0 ] 
		description: [ 'Thickness must be a pozitive number' ].

	thickness := aNumber
]

{ #category : 'accessing' }
BlTextDecoration >> type [
	^ type
]

{ #category : 'accessing' }
BlTextDecoration >> type: aBlTextDecorationType [
	type := aBlTextDecorationType
]

{ #category : 'accessing' }
BlTextDecoration >> typesDo: aBlock [
	self type typesDo: aBlock
]

{ #category : 'api - decoration' }
BlTextDecoration >> wavy [
	self style: BlTextDecorationStyle wavy
]

{ #category : 'api - decoration' }
BlTextDecoration >> withLineThrough [
	self type withLineThrough
]

{ #category : 'api - decoration' }
BlTextDecoration >> withOverline [
	self type withOverline
]

{ #category : 'api - decoration' }
BlTextDecoration >> withUnderline [
	self type withUnderline
]

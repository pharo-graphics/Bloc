Class {
	#name : 'BlTextDecorationSingleType',
	#superclass : 'BlTextDecorationType',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Text-Text-Decoration',
	#package : 'Bloc-Text',
	#tag : 'Text-Decoration'
}

{ #category : 'cleanup' }
BlTextDecorationSingleType class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlTextDecorationSingleType class >> constructor [
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlTextDecorationSingleType class >> isAbstract [
	^ self = BlTextDecorationSingleType
]

{ #category : 'accessing' }
BlTextDecorationSingleType class >> label [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlTextDecorationSingleType class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'comparing' }
BlTextDecorationSingleType >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'comparing' }
BlTextDecorationSingleType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : 'printing' }
BlTextDecorationSingleType >> printOn: aStream [
	aStream nextPutAll: self class label
]

{ #category : 'printing' }
BlTextDecorationSingleType >> storeOn: aStream [
	aStream
		nextPutAll: BlTextDecorationType name;
		space;
		nextPutAll: self class constructor
]

{ #category : 'enumerating' }
BlTextDecorationSingleType >> typesDo: aBlock [
	aBlock value: self
]

{ #category : 'logical operations' }
BlTextDecorationSingleType >> | anOtherDecorationType [
	^ BlTextDecorationCompositeType new
		addType: self;
		addType: anOtherDecorationType;
		yourself
]

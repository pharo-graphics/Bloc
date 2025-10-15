Class {
	#name : #BlBitflags,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Bloc-DataStructure - Bitflags'
}

{ #category : #'private - class code' }
BlBitflags class >> defineFlagAccessorFor: flagName [
	"Define accessors as class methods"
	| code |
	
	code := flagName, '
	"This method was automatically generated"
	^ ', flagName, ' value'.
	
	self class 
		compile: code 
		classified: self generatedFlagsProtocolName.
]

{ #category : #'private - instance code' }
BlBitflags class >> defineFlagAddAccessorFor: flagName [
	| code |
	
	code := 'add', flagName, '
	"This method was automatically generated"
	value := value | ', flagName, ' value'.

	self 
		compile: code 
		classified: self generatedFlagsAddProtocolName
]

{ #category : #'private - instance code' }
BlBitflags class >> defineFlagClearAccessorFor: flagName [
	| code |
	
	code := 'clear', flagName, '
	"This method was automatically generated"
	value := value & (', flagName, ' value bitInvert)'.

	self 
		compile: code 
		classified: self generatedFlagsClearProtocolName
]

{ #category : #'private - instance code' }
BlBitflags class >> defineFlagTestAccessorFor: flagName [
	| code |
	
	code := 'has', flagName, '
	"This method was automatically generated"
	^ (value & ', flagName, ' value) ~= 0'.

	self 
		compile: code 
		classified: self generatedFlagsTestingProtocolName
]

{ #category : #'flags declaration' }
BlBitflags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	
	"^ {
		#A.
		#B.
		#C -> 4.
		#D -> [ 8 ]
	}"
	
	^ self subclassResponsibility
]

{ #category : #private }
BlBitflags class >> flagsDictionary [
	| decl theCurrentDeclarations |
	
	self = BlBitflags
		ifTrue: [ ^ Dictionary new ].
	
	theCurrentDeclarations := Dictionary new.
	
	self flagsDecl doWithIndex: [ :eachDeclaration :eachIndex |
		| aKey aValue |
		
		(eachDeclaration isKindOf: Association)
			ifTrue: [
				aKey := eachDeclaration key.
				aValue := eachDeclaration value isClosure
					ifTrue: [ eachDeclaration value cull: theCurrentDeclarations ]
					ifFalse: [ eachDeclaration value value ] ]
			ifFalse: [
				aKey := eachDeclaration.
				aValue := (1 << (eachIndex - 1)) ].
		theCurrentDeclarations at: aKey put: aValue ].

	decl := theCurrentDeclarations.
	decl := (decl associations collect: [ :each |
		| key |
		key := self generateFlagName: each key.
		key -> each value ]) asDictionary.
	^ decl
]

{ #category : #'instance creation' }
BlBitflags class >> fromFlags: aBlInfiniteFlags [
	^ self fromValue: aBlInfiniteFlags value
]

{ #category : #'instance creation' }
BlBitflags class >> fromValue: aNumber [
	^ self new
		initializeWith: aNumber;
		yourself
]

{ #category : #private }
BlBitflags class >> generateFlagName: aString [

	^ String streamContents: [ :aStream |		
			aString
				splitOn: '_'
				do: [ :aPart |
					| eachPart |
					eachPart := aPart.
					(eachPart allSatisfy: [ :eachCharater | eachCharater isUppercase ])
						ifTrue: [ eachPart := eachPart asLowercase ].
					aStream nextPutAll: eachPart capitalized ] ]
]

{ #category : #'private - instance code' }
BlBitflags class >> generatedFlagsAddProtocolName [
	^ 'flags - add'
]

{ #category : #'private - instance code' }
BlBitflags class >> generatedFlagsClearProtocolName [
	^ 'flags - clear'
]

{ #category : #'private - class code' }
BlBitflags class >> generatedFlagsProtocolName [
	^ 'accessing - flags'
]

{ #category : #'private - instance code' }
BlBitflags class >> generatedFlagsTestingProtocolName [
	^ 'flags - testing'
]

{ #category : #'class initialization' }
BlBitflags class >> initialize [
	self initializeFlags
]

{ #category : #initialization }
BlBitflags class >> initializeFlags [

	self flagsDictionary keysAndValuesDo: [ :eachName :eachValue | 
		| classBinding flagValue |
		
		flagValue := eachValue.
		classBinding := self classPool associationAt: eachName asSymbol ifAbsent: [ nil ].
		classBinding 
			ifNotNil: [ classBinding value: flagValue ]
			ifNil: [ 
				self classPool add: (ClassVariable 
					key: eachName asSymbol 
					value: flagValue ) ] ]
]

{ #category : #private }
BlBitflags class >> rebuildFlagsAccessors [
	self flagsDictionary keysDo: [ :each | 
		self defineFlagAccessorFor: each.
		self defineFlagTestAccessorFor: each.
		self defineFlagClearAccessorFor: each.
		self defineFlagAddAccessorFor: each ]
]

{ #category : #operations }
BlBitflags >> and: aFlagsOrNumber [
	"Return new instance of infinite flags which is a result of bitwise and
	with provided flags or a number"
	<return: #BlBitflags>

	^ self class fromValue: (self value bitAnd: (aFlagsOrNumber value))
]

{ #category : #converting }
BlBitflags >> asDictionary [

	^ (self class classPool associations
		collect: [ :each | each key -> (self hasNamed: each key) ])
			asDictionary
]

{ #category : #removing }
BlBitflags >> clear [
	value := 0
]

{ #category : #copying }
BlBitflags >> copy [
	^ self class fromFlags: self
]

{ #category : #testing }
BlBitflags >> has: aFlag [
	^ (value bitAnd: aFlag) ~= 0
]

{ #category : #testing }
BlBitflags >> hasNamed: aFlagName [
	^ (value bitAnd: (self class classPool
		at: aFlagName
		ifAbsent: [ self error: 'Unknown flag: ', aFlagName asString ])) ~= 0
]

{ #category : #initialization }
BlBitflags >> initialize [
	super initialize.
	
	value := 0
]

{ #category : #initialization }
BlBitflags >> initializeWith: aValue [
	
	value := aValue
]

{ #category : #testing }
BlBitflags >> isEmpty [

	^ self value isZero
]

{ #category : #removing }
BlBitflags >> remove: aFlag [
	value := value bitAnd: (aFlag bitInvert)
]

{ #category : #accessing }
BlBitflags >> value [
	^ value
]

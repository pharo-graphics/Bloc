Class {
	#name : #BlInfiniteFlags,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : 'Bloc-Infinite-Flags'
}

{ #category : #'private - class code' }
BlInfiniteFlags class >> defineFlagAccesorFor: flagName [
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
BlInfiniteFlags class >> defineFlagAddAccesorFor: flagName [
	| code |
	
	code := 'add', flagName, '
	"This method was automatically generated"
	value := value | ', flagName, ' value'.

	self 
		compile: code 
		classified: self generatedFlagsAddProtocolName
]

{ #category : #'private - instance code' }
BlInfiniteFlags class >> defineFlagClearAccesorFor: flagName [
	| code |
	
	code := 'clear', flagName, '
	"This method was automatically generated"
	value := value & (', flagName, ' value bitInvert)'.

	self 
		compile: code 
		classified: self generatedFlagsClearProtocolName
]

{ #category : #'private - instance code' }
BlInfiniteFlags class >> defineFlagTestAccesorFor: flagName [
	| code |
	
	code := 'has', flagName, '
	"This method was automatically generated"
	^ (value & ', flagName, ' value) ~= 0'.

	self 
		compile: code 
		classified: self generatedFlagsTestingProtocolName
]

{ #category : #'flags declaration' }
BlInfiniteFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ #(
		
	)
]

{ #category : #private }
BlInfiniteFlags class >> flagsDictionary [
	| decl |
	decl := self flagsDecl.
	decl isDictionary
		ifFalse: [ decl := decl asDictionary ].
	decl := (decl associations collect: [ :each |
		| key |
		key := self generateFlagName: each key.
		key -> each value ]) asDictionary.
	^ decl
]

{ #category : #'instance creation' }
BlInfiniteFlags class >> fromFlags: aBlInfiniteFlags [
	^ self fromValue: aBlInfiniteFlags value
]

{ #category : #'instance creation' }
BlInfiniteFlags class >> fromValue: aNumber [
	^ self new
		initializeWith: aNumber;
		yourself
]

{ #category : #private }
BlInfiniteFlags class >> generateFlagName: aString [

	^ String streamContents: [ :aStream |
			aString asLowercase
				splitOn: '_'
				do: [ :aPart | aStream nextPutAll: aPart capitalized ] ]
]

{ #category : #'private - instance code' }
BlInfiniteFlags class >> generatedFlagsAddProtocolName [
	^ 'flags - add'
]

{ #category : #'private - instance code' }
BlInfiniteFlags class >> generatedFlagsClearProtocolName [
	^ 'flags - clear'
]

{ #category : #'private - class code' }
BlInfiniteFlags class >> generatedFlagsProtocolName [
	^ 'accessing - flags'
]

{ #category : #'private - instance code' }
BlInfiniteFlags class >> generatedFlagsTestingProtocolName [
	^ 'flags - testing'
]

{ #category : #initialization }
BlInfiniteFlags class >> initialize [
	self initializeFlags
]

{ #category : #initialization }
BlInfiniteFlags class >> initializeFlags [

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
BlInfiniteFlags class >> rebuildFlagsAccessors [
	self flagsDictionary keysDo: [ :each | 
		self defineFlagAccesorFor: each.
		self defineFlagTestAccesorFor: each.
		self defineFlagClearAccesorFor: each.
		self defineFlagAddAccesorFor: each ]
]

{ #category : #operations }
BlInfiniteFlags >> and: aFlagsOrNumber [
	"Return new instance of infinite flags which is a result of bitwise and
	with provided flags or a number"
	<return: #BlInfiniteFlags>

	^ self class fromValue: (self value & (aFlagsOrNumber value))
]

{ #category : #converting }
BlInfiniteFlags >> asDictionary [

	^ (self class classPool associations
		collect: [ :each | each key -> (self hasNamed: each key) ])
			asDictionary
]

{ #category : #removing }
BlInfiniteFlags >> clear [
	value := 0
]

{ #category : #copying }
BlInfiniteFlags >> copy [
	^ self class fromFlags: self
]

{ #category : #'gt-inspector-extension' }
BlInfiniteFlags >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite table)
		title: 'Flags';
		display: [ self asDictionary associations ];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		beMultiple;
		withSmalltalkSearch;
		send: [ :selection | 
			selection isNil 
			ifTrue:[ nil ]
			ifFalse:[ (selection size = 1) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]

{ #category : #testing }
BlInfiniteFlags >> has: aFlag [
	^ (value & aFlag) ~= 0
]

{ #category : #testing }
BlInfiniteFlags >> hasNamed: aFlagName [
	^ value & (self class classPool
		at: aFlagName
		ifAbsent: [ self error: 'Unknown flag: ', aFlagName asString ]) ~= 0
]

{ #category : #initialization }
BlInfiniteFlags >> initialize [
	super initialize.
	
	value := 0
]

{ #category : #initialization }
BlInfiniteFlags >> initializeWith: aValue [
	
	value := aValue
]

{ #category : #removing }
BlInfiniteFlags >> remove: aFlag [
	value := value & (aFlag bitInvert)
]

{ #category : #accessing }
BlInfiniteFlags >> value [
	^ value
]

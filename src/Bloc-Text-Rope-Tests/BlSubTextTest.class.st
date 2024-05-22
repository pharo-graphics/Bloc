Class {
	#name : #BlSubTextTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Rope-Tests'
}

{ #category : #running }
BlSubTextTest >> helloWorldText [

	^ BlRopedText string: 'HelloWorld'
]

{ #category : #tests }
BlSubTextTest >> testFromOneToZeroRepresentsEmptyText [

	| aSubText |
	aSubText := self helloWorldText from: 1 to: 0.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 0.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.
	self assert: aSubText asString equals: ''.

]

{ #category : #tests }
BlSubTextTest >> testFromZeroToZeroSignalsTextOutOfBoundsError [
	"Detect it's not allowed"

	| aSubText anError |
	[ aSubText := self helloWorldText from: 0 to: 0. ]
		on: BlTextOutOfBoundsError
		do: [ :e | anError := e ].
		
	self assert: anError isNotNil.
	self assert: aSubText isNil.

]

{ #category : #tests }
BlSubTextTest >> testInsertAtZero [

	| aSubText |
	aSubText := self helloWorldText from: 1 to: 0.
	aSubText insertString: '0' at: 0.
	
	self assert: aSubText text asString equals: '0HelloWorld'.
	self assert: aSubText asString equals: '0'.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 1.
	self deny: aSubText isEmpty.
	self assert: aSubText size equals: 1.
]

{ #category : #tests }
BlSubTextTest >> testInsertOutOfBoundsSignalsError [

	| aSubText anError |
	aSubText := self helloWorldText from: 1 to: 0.
	
	[ aSubText insertString: '1' at: 1 ]
		on: BlTextOutOfBoundsError
		do: [ :e | anError := e ].	
	
	self assert: anError isNotNil.
	self assert: aSubText text asString equals: 'HelloWorld'.
	self assert: aSubText asString equals: ''.
	
	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 0.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.

]

{ #category : #tests }
BlSubTextTest >> testUtf8Encoded [

	| aNumber aString aRopedText |
	aNumber := 7.
	aString := 'Hello World'.
	aRopedText := (BlRopedText string: aString)
		foreground: Color red; "Just to add complexity"
		yourself.

	self
		assert: (aRopedText first: aNumber) utf8Encoded
		equals: (aString first: aNumber) utf8Encoded

]

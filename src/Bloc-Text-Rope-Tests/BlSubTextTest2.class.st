"
I have been automatically converted and probably manually tweaked from BlSubTextExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlSubTextTest2,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Rope-Tests'
}

{ #category : #tests }
BlSubTextTest2 >> testEmptyText [

	<gtExample>
	^ '' asRopedText
]

{ #category : #tests }
BlSubTextTest2 >> testHelloWorldFrom0To0 [

	<gtExample>
	| aSubText anError |
	"not allowed"
	[ aSubText := self testHelloWorldText from: 0 to: 0 ]
		on: BlTextOutOfBoundsError
		do: [ :e | anError := e ].

	self assert: anError isNotNil.
	self assert: aSubText isNil.

	^ anError
]

{ #category : #tests }
BlSubTextTest2 >> testHelloWorldFrom1To0 [

	<gtExample>
	| aSubText |
	"cursor index: 0"
	aSubText := self testHelloWorldText from: 1 to: 0.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 0.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.
	self assert: aSubText asString equals: ''.

	^ aSubText
]

{ #category : #tests }
BlSubTextTest2 >> testHelloWorldFrom2To1 [

	<gtExample>
	| aSubText |
	aSubText := self testHelloWorldText from: 2 to: 1.

	self assert: aSubText start equals: 2.
	self assert: aSubText end equals: 1.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.
	self assert: aSubText asString equals: ''.

	^ aSubText
]

{ #category : #tests }
BlSubTextTest2 >> testHelloWorldText [

	<gtExample>
	^ 'HelloWorld' asRopedText
]

{ #category : #tests }
BlSubTextTest2 >> testInsertInHelloWorldFrom1To0At0 [

	<gtExample>
	| aSubText |
	aSubText := self testHelloWorldFrom1To0.
	aSubText insertString: '0' at: 0.

	self assert: aSubText text asString equals: '0HelloWorld'.
	self assert: aSubText asString equals: '0'.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 1.
	self assert: aSubText isEmpty not.
	self assert: aSubText size equals: 1.

	^ aSubText
]

{ #category : #tests }
BlSubTextTest2 >> testInsertInHelloWorldFrom1To0At1 [

	<gtExample>
	| aSubText anError |
	aSubText := self testHelloWorldFrom1To0.

	"not allowed"
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

	^ anError
]

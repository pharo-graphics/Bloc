Class {
	#name : 'BlSubTextExamples',
	#superclass : 'Object',
	#category : 'Bloc-Text-Examples-Model'
}

{ #category : 'instance creation' }
BlSubTextExamples >> emptyText [
	<gtExample>

	^ '' asRopedText
]

{ #category : 'instance creation' }
BlSubTextExamples >> helloWorldText [
	<gtExample>

	^ 'HelloWorld' asRopedText
]

{ #category : 'instance creation' }
BlSubTextExamples >> helloWorld_from_0_to_0 [
	<gtExample>
	| aSubText anError |
		
	"not allowed"
	[ aSubText := self helloWorldText from: 0 to: 0. ]
		on: BlTextOutOfBoundsError
		do: [ :e | anError := e ].
		
	self assert: anError isNotNil.
	self assert: aSubText isNil.
	
	^ anError
]

{ #category : 'instance creation' }
BlSubTextExamples >> helloWorld_from_1_to_0 [
	<gtExample>
	| aSubText |
	
	"cursor index: 0"
	aSubText := self helloWorldText from: 1 to: 0.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 0.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.
	self assert: aSubText asString equals: ''.
	
	^ aSubText
]

{ #category : 'instance creation' }
BlSubTextExamples >> helloWorld_from_2_to_1 [
	<gtExample>
	| aSubText |
	
	aSubText := self helloWorldText from: 2 to: 1.

	self assert: aSubText start equals: 2.
	self assert: aSubText end equals: 1.
	self assert: aSubText isEmpty.
	self assert: aSubText size equals: 0.
	self assert: aSubText asString equals: ''.
	
	^ aSubText
]

{ #category : 'instance creation' }
BlSubTextExamples >> insert_in_helloWorld_from_1_to_0_at_0 [
	<gtExample>
	| aSubText |
	
	aSubText := self helloWorld_from_1_to_0.
	aSubText insertString: '0' at: 0.
	
	self assert: aSubText text asString equals: '0HelloWorld'.
	self assert: aSubText asString equals: '0'.

	self assert: aSubText start equals: 1.
	self assert: aSubText end equals: 1.
	self assert: aSubText isEmpty not.
	self assert: aSubText size equals: 1.
	
	^ aSubText
]

{ #category : 'instance creation' }
BlSubTextExamples >> insert_in_helloWorld_from_1_to_0_at_1 [
	<gtExample>
	| aSubText anError |
	
	aSubText := self helloWorld_from_1_to_0.
	
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

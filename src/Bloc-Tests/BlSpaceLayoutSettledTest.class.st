Class {
	#name : #BlSpaceLayoutSettledTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'element'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceLayoutSettledTest >> setUp [

	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost default.
	element := BlElement new
		           extent: 10 @ 10;
		           yourself.
	space root addChild: element.
	space show.
	space settleForMilliseconds: 2000
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> tearDown [

	space close.
	super tearDown
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> testActionAddedByAnActionRunsAfterAnotherLayout [

	| order |
	order := OrderedCollection new.
	space whenLayoutSettledDo: [
			order add: 1.
			space whenLayoutSettledDo: [ order add: 2 ] ].
	space settleForMilliseconds: 2000.
	self assert: order asArray equals: #( 1 2 )
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> testActionRunsAfterTheLayoutsRequestedByTheHandlersOfTheLayout [

	| other seen |
	other := BlElement new
		         extent: 10 @ 10;
		         yourself.
	space root addChild: other.
	space settleForMilliseconds: 2000.
	element whenLayoutedDoOnce: [ other position: 50 @ 0 ].
	space whenLayoutSettledDo: [ seen := other position ].
	element requestLayout.
	space settleForMilliseconds: 2000.
	self assert: seen equals: 50 @ 0
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> testActionRunsEvenWhenNoLayoutIsRequested [

	| ran |
	ran := false.
	space whenLayoutSettledDo: [ ran := true ].
	space settleForMilliseconds: 2000.
	self assert: ran
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> testActionRunsOnceWhenTheLayoutIsDone [

	| count |
	count := 0.
	space whenLayoutSettledDo: [ count := count + 1 ].
	element requestLayout.
	space settleForMilliseconds: 2000.
	space settleForMilliseconds: 2000.
	self assert: count equals: 1
]

{ #category : #tests }
BlSpaceLayoutSettledTest >> testActionsRunInTheOrderTheyWereAdded [

	| order |
	order := OrderedCollection new.
	space whenLayoutSettledDo: [ order add: 1 ].
	space whenLayoutSettledDo: [ order add: 2 ].
	space settleForMilliseconds: 2000.
	self assert: order asArray equals: #( 1 2 )
]

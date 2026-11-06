Class {
	#name : #BlSpaceLayoutLoopTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'loopElement'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceLayoutLoopTest >> setUp [

	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost default.
	loopElement := BlLayoutLoopElement new
		               extent: 100 @ 100;
		               yourself.
	loopElement addChild: (BlElement new
			 extent: 10 @ 10;
			 yourself).
	space root addChild: loopElement
]

{ #category : #tests }
BlSpaceLayoutLoopTest >> tearDown [

	space close.
	super tearDown
]

{ #category : #tests }
BlSpaceLayoutLoopTest >> testLayoutLoopDescriptionNamesTheElementsRequestingLayout [

	| description |
	space doLayout.
	description := space layoutLoopDescription.
	self assert: (description includesSubstring: '100').
	self assert: (description includesSubstring: loopElement printString)
]

{ #category : #tests }
BlSpaceLayoutLoopTest >> testLayoutLoopEndsWhenNothingRequestsLayoutAnymore [

	space doLayout.
	self assert: space hasLayoutLoop.
	loopElement stopLooping.
	space doLayout.
	self deny: space hasLayoutLoop
]

{ #category : #tests }
BlSpaceLayoutLoopTest >> testLayoutWhichKeepsRequestingLayoutStopsAtTheLimitOfPasses [

	space doLayout.
	self assert: loopElement passes equals: 100.
	self assert: space hasLayoutLoop
]

{ #category : #tests }
BlSpaceLayoutLoopTest >> testLayoutWhichSettlesIsNotALoop [

	loopElement stopLooping.
	space doLayout.
	self deny: space hasLayoutLoop
]

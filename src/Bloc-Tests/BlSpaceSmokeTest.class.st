Class {
	#name : #BlSpaceSmokeTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceSmokeTest >> testImmediateCloseAfterShow [

	| aSpace universe |
	aSpace := self newTestingSpace.
	universe := aSpace universe.
	aSpace close.
	self waitTestingSpaces.
	self deny: (universe spaces includes: aSpace).
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceSmokeTest >> testShowAfterClose [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator
		click;
		waitPendingWork.
	aSpace close.
	self waitTestingSpaces.
	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator
		click;
		waitPendingWork.

]

{ #category : #tests }
BlSpaceSmokeTest >> testShowAndClick [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator
		click;
		waitPendingWork.

]

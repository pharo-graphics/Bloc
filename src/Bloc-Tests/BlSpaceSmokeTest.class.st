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
	aSpace settle.
	self deny: (universe spaces includes: aSpace).
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceSmokeTest >> testShowAfterClose [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click.
	aSpace close.
	aSpace settle.
	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click
]

{ #category : #tests }
BlSpaceSmokeTest >> testShowAndClick [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click
]

{ #category : #tests }
BlSpaceSmokeTest >> testValidateHostSpaceDrawing [

	| aSpace |
	aSpace := BlSpace new.
	aSpace validateHostSpaceDrawing.
	self deny: aSpace isOpened.

	aSpace := self newTestingSpace.
	aSpace validateHostSpaceDrawing.
	self assert: aSpace isOpened
]

Class {
	#name : 'BlSpaceSmokeTest',
	#superclass : 'BlParameterizedHostTest',
	#category : 'Bloc-Tests-Space',
	#package : 'Bloc-Tests',
	#tag : 'Space'
}

{ #category : 'tests' }
BlSpaceSmokeTest >> testShowAfterClose [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	BlSpace simulateClickOn: aSpace root.
	self waitTestingSpaces.
	aSpace close.
	self waitTestingSpaces.
	aSpace show.
	self waitTestingSpaces.
	BlSpace simulateClickOn: aSpace root.
	self waitTestingSpaces.

]

{ #category : 'tests' }
BlSpaceSmokeTest >> testShowAndClick [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	BlSpace simulateClickOn: aSpace root.
	self waitTestingSpaces.

]

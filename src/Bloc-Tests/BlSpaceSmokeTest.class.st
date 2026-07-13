Class {
	#name : #BlSpaceSmokeTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceSmokeTest >> testShowAfterClose [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator click.
	self waitTestingSpaces.
	aSpace close.
	self waitTestingSpaces.
	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator click.
	self waitTestingSpaces.

]

{ #category : #tests }
BlSpaceSmokeTest >> testShowAndClick [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	self waitTestingSpaces.
	aSpace root eventSimulator click.
	self waitTestingSpaces.

]

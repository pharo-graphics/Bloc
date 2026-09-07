Class {
	#name : #BlSpaceSmokeTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceSmokeTest >> testHostSpaceOpenAndClose [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost default.
	self deny: aSpace hasHostSpace.

	aSpace hostSpaceOpen.
	self assert: aSpace hasHostSpace.
	self assert: aSpace hostSpace isValid.

	aSpace hostSpaceClose.
	self deny: aSpace hasHostSpace
]

{ #category : #tests }
BlSpaceSmokeTest >> testImmediateCloseAfterShow [

	| aSpace |
	aSpace := self newTestingSpace.
	aSpace close.
	aSpace settle.
	self deny: (aSpace host hasSpace: aSpace).
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceSmokeTest >> testOnSessionChanged [

	| aSpace |
	aSpace := self newTestingSpace.
	aSpace onSessionChanged.
	self assert: aSpace isOpened
]

{ #category : #tests }
BlSpaceSmokeTest >> testOpenAndClose [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost default.
	self deny: aSpace isOpened.

	aSpace open.
	aSpace settle.
	self assert: aSpace isOpened.

	aSpace close.
	aSpace settle.
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

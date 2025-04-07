Class {
	#name : #BlImageBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Background'
}

{ #category : #running }
BlImageBackgroundTest >> newBlueForm [

	^ (Form extent: 50 @ 50 depth: 32)
			fillColor: Color blue;
			yourself
]

{ #category : #'background - image' }
BlImageBackgroundTest >> testBlueImageBackgroundExplicitInitialization [

	| aBackground |
	aBackground :=
		BlImageBackground new
			image: self newBlueForm;
			yourself.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

{ #category : #'background - image' }
BlImageBackgroundTest >> testBlueImageBackgroundExplicitInstantiation [

	| aBackground |
	aBackground := BlImageBackground image: self newBlueForm.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

{ #category : #'background - image' }
BlImageBackgroundTest >> testBlueImageWithPositiveExtentBackground [

	| aBackground |
	aBackground := self newBlueForm asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

{ #category : #'background - image' }
BlImageBackgroundTest >> testEmptyImageBackground [

	| aBackground |
	aBackground := (Form extent: 0@0) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Form extent: 0@0) bits
]

{ #category : #'background - image' }
BlImageBackgroundTest >> testEmptyImageWithPositiveExtentBackground [

	| aBackground |
	aBackground := (Form extent: 50@50) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: (Form extent: 50@50) bits
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> testIconImageBackground [

	| aBackground |
	aBackground := self newBlueForm asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> testImageWithOpacityBackground [

	| aBackground |
	aBackground := self newBlueForm asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.2.
	self deny: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> testImageWithZeroOpacityBackground [

	| aBackground |
	aBackground := self newBlueForm asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: self newBlueForm bits
]

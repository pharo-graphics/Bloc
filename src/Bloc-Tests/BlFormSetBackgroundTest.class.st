Class {
	#name : #BlFormSetBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Background'
}

{ #category : #running }
BlFormSetBackgroundTest >> newBlueFormSet [

	^ FormSet forms: ((1 to: 2) collect: [ :scale |
		(Form extent: 50 @ 50 * scale depth: 32) fillColor: Color blue; yourself ])
]

{ #category : #'background - image' }
BlFormSetBackgroundTest >> testBlueImageBackgroundExplicitInitialization [

	| aBackground |
	aBackground :=
		BlFormSetBackground new
			formSet: self newBlueFormSet;
			yourself.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

{ #category : #'background - image' }
BlFormSetBackgroundTest >> testBlueImageBackgroundExplicitInstantiation [

	| aBackground |
	aBackground := BlFormSetBackground formSet: self newBlueFormSet.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

{ #category : #'background - image' }
BlFormSetBackgroundTest >> testBlueImageWithPositiveExtentBackground [

	| aBackground |
	aBackground := self newBlueFormSet asBlBackground.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

{ #category : #'background - image' }
BlFormSetBackgroundTest >> testEmptyImageBackground [

	| aBackground |
	aBackground := (FormSet form: (Form extent: 0@0)) asBlBackground.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: { (Form extent: 0@0) bits }
]

{ #category : #'background - image' }
BlFormSetBackgroundTest >> testEmptyImageWithPositiveExtentBackground [

	| aBackground |
	aBackground := (FormSet form: (Form extent: 50@50)) asBlBackground.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: { (Form extent: 50@50) bits }
]

{ #category : #'background - icon' }
BlFormSetBackgroundTest >> testIconImageBackground [

	| aBackground |
	aBackground := self newBlueFormSet asBlBackground.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

{ #category : #'background - icon' }
BlFormSetBackgroundTest >> testImageWithOpacityBackground [

	| aBackground |
	aBackground := self newBlueFormSet asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 0.2.
	self deny: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

{ #category : #'background - icon' }
BlFormSetBackgroundTest >> testImageWithZeroOpacityBackground [

	| aBackground |
	aBackground := self newBlueFormSet asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlFormSetBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: (aBackground formSet forms collect: #bits) equals: (self newBlueFormSet forms collect: #bits)
]

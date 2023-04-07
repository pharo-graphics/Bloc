Class {
	#name : #BlImageBackgroundTest,
	#superclass : #BlBackgroundTest,
	#category : #'Bloc-Examples-DocumentationExamples'
}

{ #category : #'background - image' }
BlImageBackgroundTest >> blueImageBackgroundExplicitInitialization [
	<gtExample>
	| aBackground |
	
	aBackground := BlImageBackground new
		image: ((Form extent: 50@50 depth: 32) fillColor: Color blue).

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundTest >> blueImageBackgroundExplicitInstantiation [
	<gtExample>
	| aBackground |
	
	aBackground := BlImageBackground image: ((Form extent: 50@50 depth: 32) fillColor: Color blue).

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundTest >> blueImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := ((Form extent: 50@50 depth: 32) fillColor: Color blue) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundTest >> emptyImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 0@0) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Form extent: 0@0) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundTest >> emptyImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 50@50) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Form extent: 50@50) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> iconImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> imageWithOpacityBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.2.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> imageWithZeroOpacityBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundTest >> pharoLogoImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := PolymorphSystemSettings pharoLogoForm asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: PolymorphSystemSettings pharoLogoForm bits.

	^ aBackground
]

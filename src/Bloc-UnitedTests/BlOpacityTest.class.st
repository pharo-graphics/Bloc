"
I have been automatically converted and probably manually tweaked from BlOpacityExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlOpacityTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Basic'
}

{ #category : #'tests seed' }
BlOpacityTest >> colorfulElement [

	| anElement |
	anElement := BlElement new.
	anElement extent: 100 @ 75.
	anElement
		background:
			((BlLinearGradientPaint direction: 1 @ 1)
				from: Color red
				to: Color blue).
	anElement
		border:
			(BlBorder
				paint:
					((BlLinearGradientPaint direction: 1 @ 1)
						matchExtent: 100 @ 75;
						from: Color blue to: Color red)
				width: 5).
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 20).
	^ anElement
]

{ #category : #tests }
BlOpacityTest >> testDefaultOpacity [

	| anElement |
	anElement := self colorfulElement.
	self assert: anElement opacity equals: 1.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque.
	^ anElement
]

{ #category : #tests }
BlOpacityTest >> testMakeOpaque [

	| anElement |
	anElement := self colorfulElement.
	anElement opacity: 1.
	self assert: anElement opacity equals: 1.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque.
	^ anElement
]

{ #category : #tests }
BlOpacityTest >> testMakeTranslucent [

	| anElement |
	anElement := self colorfulElement.
	anElement opacity: 0.5.
	self assert: anElement opacity equals: 0.5.
	self assert: anElement isTransparent not.
	self assert: anElement isTranslucent.
	self assert: anElement isOpaque not.
	^ anElement
]

{ #category : #tests }
BlOpacityTest >> testMakeTransparent [

	| anElement |
	anElement := self colorfulElement.
	anElement opacity: 0.
	self assert: anElement opacity equals: 0.
	self assert: anElement isTransparent.
	self assert: anElement isTranslucent not.
	self assert: anElement isOpaque not.
	^ anElement
]

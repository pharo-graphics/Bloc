"
I have been automatically converted and probably manually tweaked from BlTextDecorationStyleExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : 'BlTextDecorationStyleTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Text-Tests',
	#package : 'Bloc-Text-Tests'
}

{ #category : 'tests' }
BlTextDecorationStyleTest >> testDashed [

	<sampleInstance>
	| aStyle |
	aStyle := BlTextDecorationStyle dashed.

	self assert: aStyle class equals: BlTextDecorationDashedStyle.
	self assert: aStyle class label equals: 'Dashed'.
	self assert: aStyle class constructor equals: #dashed.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Object evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : 'tests' }
BlTextDecorationStyleTest >> testDotted [

	<sampleInstance>
	| aStyle |
	aStyle := BlTextDecorationStyle dotted.

	self assert: aStyle class equals: BlTextDecorationDottedStyle.
	self assert: aStyle class label equals: 'Dotted'.
	self assert: aStyle class constructor equals: #dotted.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Object evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : 'tests' }
BlTextDecorationStyleTest >> testDouble [

	<sampleInstance>
	| aStyle |
	aStyle := BlTextDecorationStyle double.

	self assert: aStyle class equals: BlTextDecorationDoubleStyle.
	self assert: aStyle class label equals: 'Double'.
	self assert: aStyle class constructor equals: #double.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Object evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : 'tests' }
BlTextDecorationStyleTest >> testSolid [

	<sampleInstance>
	| aStyle |
	aStyle := BlTextDecorationStyle solid.

	self assert: aStyle class equals: BlTextDecorationSolidStyle.
	self assert: aStyle class label equals: 'Solid'.
	self assert: aStyle class constructor equals: #solid.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Object evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

{ #category : 'tests' }
BlTextDecorationStyleTest >> testWavy [

	<sampleInstance>
	| aStyle |
	aStyle := BlTextDecorationStyle wavy.

	self assert: aStyle class equals: BlTextDecorationWavyStyle.
	self assert: aStyle class label equals: 'Wavy'.
	self assert: aStyle class constructor equals: #wavy.
	self assert: aStyle class isAbstract not.
	self assert: aStyle equals: aStyle class new.
	self assert: aStyle hash equals: aStyle class hash.
	self assert: aStyle printString equals: aStyle class label.
	self assert: (Object evaluate: aStyle storeString) equals: aStyle.

	^ aStyle
]

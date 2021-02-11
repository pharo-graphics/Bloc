"
I have been automatically converted and probably manually tweaked from BlElementChildrenExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementChildrenTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests'
}

{ #category : #metadata }
BlElementChildrenTest >> originClassName [
	"This test was generated from..."
	^ 'BlElementChildrenExamples'
]

{ #category : #tests }
BlElementChildrenTest >> overlappingChildren [
	<gtExample>
	| aContainer aRedChild aBlueChild |
	aContainer := BlElement new
		size: 400 @ 400;
		background: Color veryVeryLightGray;
		labeled: 'Container'.
	aRedChild := BlElement new
		size: 300 @ 150;
		relocate: 50 @ 125;
		background: (Color red alpha: 0.5);
		labeled: 'Red'.
	aBlueChild := BlElement new
		size: 150 @ 300;
		relocate: 125 @ 50;
		background: (Color blue alpha: 0.5);
		labeled: 'Blue'.
	aContainer addChild: aRedChild as: #red.
	aContainer addChild: aBlueChild as: #blue.
	aContainer forceLayout.
	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt100200 [
	<gtExample>
	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 100 @ 200.
	self assert: theChildren equals: {(aContainer childNamed: #red)}.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt200100 [
	<gtExample>
	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200 @ 100.
	self assert: theChildren equals: {(aContainer childNamed: #blue)}.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt200200 [
	<gtExample>
	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200 @ 200.
	self
		assert: theChildren
		equals:
			{(aContainer childNamed: #blue).
			(aContainer childNamed: #red)}.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt5050 [
	<gtExample>
	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 50 @ 50.
	self assert: theChildren equals: {aContainer}.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt600600 [
	<gtExample>
	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 600 @ 600.
	self assert: theChildren equals: {}.
	^ theChildren
]

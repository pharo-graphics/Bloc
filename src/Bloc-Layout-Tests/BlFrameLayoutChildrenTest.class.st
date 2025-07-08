"
I have been automatically converted and probably manually tweaked from BlFrameLayoutChildrenExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlFrameLayoutChildrenTest,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlFrameLayoutChildrenTest >> testChildElementWithExactSize100per50 [

	<sampleInstance>
	<demo>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical exact: 50 ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assertExactConstraint: 100 @ 50 forElement: element.
	^ element
]

{ #category : #tests }
BlFrameLayoutChildrenTest >> testParentWithFrameLayoutAndFixedSize [

	<sampleInstance>
	<demo>
	| element |
	element := self parentWithFixedSize.
	element layout: BlFrameLayout new.
	self assert: element layout class equals: BlFrameLayout.
	^ element
]

{ #category : #tests }
BlFrameLayoutChildrenTest >> testParentWithFrameLayoutAndFixedSize300per250 [

	<sampleInstance>
	<demo>
	| element |
	element := BlElement new
		           layout: BlFrameLayout new;
		           border: (BlBorder builder
				            dashed;
				            paint: Color red;
				            width: 3;
				            build);
		           extent: 300 @ 250;
		           yourself.
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assert: element constraints horizontal resizer size equals: 300.
	self assert: element constraints vertical resizer size equals: 250.
	self assert: element layout class equals: BlFrameLayout.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	^ element
]

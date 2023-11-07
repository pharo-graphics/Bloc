Class {
	#name : #BlFrameLayoutChildrenTestDemo,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Demo-FromTests'
}

{ #category : #'tests - demo' }
BlFrameLayoutChildrenTestDemo >> testChildElementWithExactSize100per50 [
	<sampleInstance>
	| element |
	element := self testChildElementWithVisualProperties.
	element
		constraintsDo: [ :c | 
			c horizontal exact: 100.
			c vertical exact: 50 ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assertExactConstraint: 100 @ 50 forElement: element.
	^ element
]

{ #category : #'tests - demo' }
BlFrameLayoutChildrenTestDemo >> testParentWithFrameLayoutAndFixedSize [
	<sampleInstance>
	| element |
	element := self parentWithFixedSize.
	element layout: BlFrameLayout new.
	self assert: element layout class equals: BlFrameLayout.
	^ element
]

{ #category : #'tests - demo' }
BlFrameLayoutChildrenTestDemo >> testParentWithFrameLayoutAndFixedSize300per250 [
	<sampleInstance>
	| element |
	element := BlElement new
		layout: BlFrameLayout new;
		border:
			(BlBorder builder
				dashed;
				paint: Color red;
				width: 3;
				build);
		size: 300 @ 250;
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

"
I have been automatically converted and probably manually tweaked from BlLayoutChildNodeWithTransformationExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlLayoutChildNodeWithTransformationTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLayoutChildNodeWithTransformationTest >> testNodeWithScale [

	<sampleInstance>
	| aTransformation aChildNode aChildNodeWithTransformation |
	aTransformation := self testScaleTransformation.

	aChildNode := BlLayoutChildNode new
		              constraints: BlLayoutCommonConstraints new;
		              measurement:
			              (BlLayoutNodeComputedMeasurement extent: 100 @ 100);
		              yourself.

	aChildNodeWithTransformation :=
		aChildNode withTransformation: aTransformation.

	self
		assert: aChildNodeWithTransformation position
		equals: (50 @ 50) negated.
	self assert: aChildNodeWithTransformation extent equals: 200 @ 200.

	^ aChildNodeWithTransformation
]

{ #category : #tests }
BlLayoutChildNodeWithTransformationTest >> testScaleTransformation [
	<sampleInstance>

	| aScaleTransformation aTransformation |
	aScaleTransformation := BlScalingTransformation new
		                        origin: BlAffineTransformationCenterOrigin defaultInstance;
		                        scale: (BlVector x: 2 y: 2).

	aTransformation := BlElementLocalTransformation newWith: aScaleTransformation.

	^ aTransformation
]

{ #category : #tests }
BlLayoutChildNodeWithTransformationTest >> testSetPositionNodeWithScale [

	<sampleInstance>
	| aChildNodeWithTransformation |
	aChildNodeWithTransformation := self testNodeWithScale.

	aChildNodeWithTransformation position: 0 @ 0.
	self assert: aChildNodeWithTransformation position equals: 0 @ 0.

	aChildNodeWithTransformation position: 20 @ 30.
	self assert: aChildNodeWithTransformation position equals: 20 @ 30.

	^ aChildNodeWithTransformation
]

Class {
	#name : #BlLayoutChildNodeWithTransformationExamples,
	#superclass : #BlLayoutNodeExamples,
	#category : #'Bloc-Layout-Examples-Core'
}

{ #category : #'examples - transformation' }
BlLayoutChildNodeWithTransformationExamples >> nodeWithScale [
	<gtExample>
	| aTransformation aChildNode aChildNodeWithTransformation |

	aTransformation := self scaleTransformation.

	aChildNode := BlLayoutChildNode new
		constraints: BlLayoutCommonConstraints new;
		measurement: (BlLayoutNodeComputedMeasurement new extent: 100@100).

	aChildNodeWithTransformation := aChildNode withTransformation: aTransformation.

	self assert: aChildNodeWithTransformation position equals: (50@50) negated.
	self assert: aChildNodeWithTransformation extent equals: (200@200).

	^ aChildNodeWithTransformation
]

{ #category : #'examples - instance creation' }
BlLayoutChildNodeWithTransformationExamples >> scaleTransformation [
	<gtExample>
	| aScaleTransformation aTransformation |
	
	aScaleTransformation := BlScalingTransformation new
		origin: BlAffineTransformationCenterOrigin new;
		scale: (BlVector x: 2 y: 2).
	
	aTransformation := (BlElementLocalTransformation with: aScaleTransformation).
	
	^ aTransformation
]

{ #category : #'examples - transformation' }
BlLayoutChildNodeWithTransformationExamples >> setPositionNodeWithScale [
	<gtExample>
	| aChildNodeWithTransformation |
	
	aChildNodeWithTransformation := self nodeWithScale.
	
	aChildNodeWithTransformation position: 0@0.
	self assert: aChildNodeWithTransformation position equals: 0@0.
	
	aChildNodeWithTransformation position: 20@30.
	self assert: aChildNodeWithTransformation position equals: 20@30.

	^ aChildNodeWithTransformation
]

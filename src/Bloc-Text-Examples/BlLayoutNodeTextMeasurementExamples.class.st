Class {
	#name : 'BlLayoutNodeTextMeasurementExamples',
	#superclass : 'Object',
	#category : 'Bloc-Text-Examples-Measurement'
}

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> baseline [
	<gtExample>

	^ BlTextParagraphAscentLooseBaseline new
]

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> boundsMeasurement [
	<gtExample>

	^ BlTextElementLabelMeasurementStrategy new
]

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> layoutChildNode [
	<gtExample>

	^ BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (self layoutNodeMeasurement);
		fitContent
]

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> layoutNodeMeasurement [
	<gtExample>

	^ BlLayoutNodeTextMeasurement new
		text: self text;
		baseline: self baseline;
		measurer: self mockedMeasurer;
		boundsMeasurement: self boundsMeasurement
]

{ #category : 'measurement' }
BlLayoutNodeTextMeasurementExamples >> measureLayoutChildNode [
	<gtExample>
	| aLayoutNode |
	
	aLayoutNode := self layoutChildNode.
	aLayoutNode measure: (BlExtentMeasurementSpec unspecified).
	
	^ aLayoutNode
]

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> mockedMeasurer [
	<gtExample>

	^ BlMockedTextMeasurer new
		ascent: -10;
		descent: 5;
		glyphWidth: 10;
		height: 15
]

{ #category : 'instance creation' }
BlLayoutNodeTextMeasurementExamples >> text [
	<gtExample>

	^ 'Hello' asRopedText
]

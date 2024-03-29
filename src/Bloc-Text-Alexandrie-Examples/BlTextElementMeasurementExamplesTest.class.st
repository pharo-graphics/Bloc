Class {
	#name : #BlTextElementMeasurementExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Alexandrie-Examples'
}

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesTest >> ascent [
	^ -50
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> customMeasurer [

	<sampleInstance>
	^ BATextElementMockedMeasurer new
		  ascent: self ascent;
		  descent: self descent;
		  glyphHeight: self glyphHeight;
		  glyphWidth: self glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesTest >> descent [
	^ 50
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesTest >> glyphHeight [
	^ self ascent abs + self descent - 20
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesTest >> glyphWidth [
	^ 60
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamplesTest >> helloWorldText [

	<sampleInstance>
	^ 'Hello world' asRopedText fontSize: 80
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtent [

	<sampleInstance>
	| aTextElement |
	aTextElement := self textElementWithCustomMeasurer.
	aTextElement measure: BlExtentMeasurementSpec unspecified.

	self
		assert: aTextElement measuredWidth
		equals: self helloWorldText size * self glyphWidth.
	self assert: aTextElement measuredHeight equals: self glyphHeight.

	^ aTextElement
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtentShouldRemeasure [

	<sampleInstance>
	| aTextElement |
	aTextElement := self testUnspecifiedExtent.

	self assert:
		(aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified)
			not.

	^ aTextElement
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtentWithMaxHeight [

	<sampleInstance>
	| aTextElement |
	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c |
		c maxHeight: self ascent abs + self descent / 2 ].
	aTextElement measure: BlExtentMeasurementSpec unspecified.

	self
		assert: aTextElement measuredWidth
		equals: self helloWorldText size * self glyphWidth.
	self
		assert: aTextElement measuredHeight
		equals: self ascent abs + self descent / 2.

	^ aTextElement
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtentWithMaxHeightShouldRemeasure [

	<sampleInstance>
	| aTextElement |
	aTextElement := self testUnspecifiedExtentWithMaxHeight.

	self assert:
		(aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified)
			not.

	^ aTextElement
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtentWithMaxWidth [

	<sampleInstance>
	| aTextElement |
	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c |
		c maxWidth: self helloWorldText size * self glyphWidth / 2 ].
	aTextElement measure: BlExtentMeasurementSpec unspecified.

	self
		assert: aTextElement measuredWidth
		equals: self helloWorldText size * self glyphWidth / 2.
	self assert: aTextElement measuredHeight equals: self glyphHeight.

	^ aTextElement
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> testUnspecifiedExtentWithMaxWidthShouldRemeasure [

	<sampleInstance>
	| aTextElement |
	aTextElement := self testUnspecifiedExtentWithMaxWidth.

	self assert:
		(aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified)
			not.

	^ aTextElement
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamplesTest >> textElement [

	<sampleInstance>
	^ BlTextElement new
		  border: (BlBorder paint: (Color gray alpha: 0.8) width: 2);
		  background: (Color gray alpha: 0.2);
		  text: self helloWorldText
]

{ #category : #example }
BlTextElementMeasurementExamplesTest >> textElementWithCustomMeasurer [

	<sampleInstance>
	^ self textElement measurer: self customMeasurer
]

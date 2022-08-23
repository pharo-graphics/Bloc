Class {
	#name : #BlTextElementMeasurementExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Text-Examples-Measurement'
}

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> ascent [
	^ -50
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamples >> customMeasurer [
	<gtExample>
	
	^ BlTextElementMockedMeasurer new
		ascent: self ascent;
		descent: self descent;
		glyphHeight: self glyphHeight;
		glyphWidth: self glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> descent [
	^ 50
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> glyphHeight [
	^ self ascent abs + self descent - 20
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> glyphWidth [
	^ 60
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamples >> helloWorldText [
	<gtExample>

	^ 'Hello world' asRopedText fontSize: 80
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamples >> textElement [
	<gtExample>
	
	^ BlTextElement new
		border: (BlBorder paint: (Color gray alpha: 0.8) width: 2);
		background: (Color gray alpha: 0.2);
		text: self helloWorldText
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamples >> textElementWithCustomMeasurer [
	<gtExample>
	
	^ self textElement
		measurer: self customMeasurer
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtent [
	<gtExample>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self glyphHeight).

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtent.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxHeight [
	<gtExample>
	| aTextElement |
	
	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c | c maxHeight: (self ascent abs + self descent) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self ascent abs + self descent) / 2.

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxHeightShouldRemeasure [
	<gtExample>
	| aTextElement |
	
	aTextElement := self unspecifiedExtentWithMaxHeight.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxWidth [
	<gtExample>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c | c maxWidth: (self helloWorldText size * self glyphWidth) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth) / 2.
	self assert: aTextElement measuredHeight equals: (self glyphHeight).

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxWidthShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtentWithMaxWidth.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

Class {
	#name : #BlTextElementMeasurementExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Text'
}

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> ascent [
	^ 50
]

{ #category : #'instance creation' }
BlTextElementMeasurementExamples >> customMeasurer [
	<gtExample>
	
	^ BlTextElementFixedMeasurer new
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
	^ self ascent + self descent - 20
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
	<noTest>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self ascent + self descent).

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentShouldRemeasure [
	<gtExample>
	<noTest>
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
	aTextElement constraintsDo: [ :c | c maxHeight: (self ascent + self descent) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self ascent + self descent) / 2.

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
	<noTest>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c | c maxWidth: (self helloWorldText size * self glyphWidth) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth) / 2.
	self assert: aTextElement measuredHeight equals: (self ascent + self descent).

	^ aTextElement
]

{ #category : #'text - fit content' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxWidthShouldRemeasure [
	<gtExample>
	<noTest>
	| aTextElement |

	aTextElement := self unspecifiedExtentWithMaxWidth.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

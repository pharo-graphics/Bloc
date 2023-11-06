Class {
	#name : #BlTextElementMeasurementExamplesDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesDemo >> ascent [
	^ -50
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> customMeasurer [
	<gtExample>
	
	^ BATextElementMockedMeasurer  new
		ascent: self ascent;
		descent: self descent;
		glyphHeight: self glyphHeight;
		glyphWidth: self glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesDemo >> descent [
	^ 50
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesDemo >> glyphHeight [
	^ self ascent abs + self descent - 20
]

{ #category : #'font - metrics' }
BlTextElementMeasurementExamplesDemo >> glyphWidth [
	^ 60
]

{ #category : #'instance creation - demo' }
BlTextElementMeasurementExamplesDemo >> helloWorldText [
	<gtExample>

	^ 'Hello world' asRopedText fontSize: 80
]

{ #category : #'instance creation - demo' }
BlTextElementMeasurementExamplesDemo >> textElement [
	<gtExample>
	
	^ BlTextElement new
		border: (BlBorder paint: (Color gray alpha: 0.8) width: 2);
		background: (Color gray alpha: 0.2);
		text: self helloWorldText
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> textElementWithCustomMeasurer [
	<gtExample>
	
	^ self textElement
		measurer: self customMeasurer
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtent [
	<gtExample>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self glyphHeight).

	^ aTextElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtentShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtent.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtentWithMaxHeight [
	<gtExample>
	| aTextElement |
	
	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c | c maxHeight: (self ascent abs + self descent) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self ascent abs + self descent) / 2.

	^ aTextElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtentWithMaxHeightShouldRemeasure [
	<gtExample>
	| aTextElement |
	
	aTextElement := self unspecifiedExtentWithMaxHeight.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtentWithMaxWidth [
	<gtExample>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement constraintsDo: [ :c | c maxWidth: (self helloWorldText size * self glyphWidth) / 2 ]. 
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth) / 2.
	self assert: aTextElement measuredHeight equals: (self glyphHeight).

	^ aTextElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementExamplesDemo >> unspecifiedExtentWithMaxWidthShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtentWithMaxWidth.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

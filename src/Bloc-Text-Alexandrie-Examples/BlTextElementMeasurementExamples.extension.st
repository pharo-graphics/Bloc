Extension { #name : #BlTextElementMeasurementExamples }

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> customMeasurer [
	<gtExample>
	
	^ BATextElementMockedMeasurer  new
		ascent: self ascent;
		descent: self descent;
		glyphHeight: self glyphHeight;
		glyphWidth: self glyphWidth
]

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> textElementWithCustomMeasurer [
	<gtExample>
	
	^ self textElement
		measurer: self customMeasurer
]

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> unspecifiedExtent [
	<gtExample>
	| aTextElement |

	aTextElement := self textElementWithCustomMeasurer.
	aTextElement measure: (BlExtentMeasurementSpec unspecified).

	self assert: aTextElement measuredWidth equals: (self helloWorldText size * self glyphWidth).
	self assert: aTextElement measuredHeight equals: (self glyphHeight).

	^ aTextElement
]

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> unspecifiedExtentShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtent.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
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

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxHeightShouldRemeasure [
	<gtExample>
	| aTextElement |
	
	aTextElement := self unspecifiedExtentWithMaxHeight.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
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

{ #category : #'*Bloc-Text-Alexandrie-Examples' }
BlTextElementMeasurementExamples >> unspecifiedExtentWithMaxWidthShouldRemeasure [
	<gtExample>
	| aTextElement |

	aTextElement := self unspecifiedExtentWithMaxWidth.

	self assert: (aTextElement shouldMeasure: BlExtentMeasurementSpec unspecified) not.

	^ aTextElement
]

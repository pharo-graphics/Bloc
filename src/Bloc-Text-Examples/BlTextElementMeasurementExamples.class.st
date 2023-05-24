Class {
	#name : #BlTextElementMeasurementExamples,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Text-Examples-Measurement'
}

{ #category : #'font - metrics' }
BlTextElementMeasurementExamples >> ascent [
	^ -50
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

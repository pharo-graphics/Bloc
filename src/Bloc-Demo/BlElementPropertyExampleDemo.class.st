Class {
	#name : #BlElementPropertyExampleDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #properties }
BlElementPropertyExampleDemo >> backgroundProperty [

	<sampleInstance>
	^ BlElementBackgroundProperty new background: (Color gray alpha: 0.2)
]

{ #category : #properties }
BlElementPropertyExampleDemo >> borderProperty [

	<sampleInstance>
	^ BlElementBorderProperty new border:
		  (BlBorder paint: Color veryLightGray width: 2)
]

{ #category : #examples }
BlElementPropertyExampleDemo >> elementWithMultipleProperties [

	<sampleInstance>
	| anElement |
	anElement := BlElement new.
	anElement properties addProperties: {
			self widthProperty.
			self heightProperty.
			self geometryProperty.
			self backgroundProperty.
			self borderProperty }.

	^ anElement
]

{ #category : #properties }
BlElementPropertyExampleDemo >> geometryProperty [

	<sampleInstance>
	^ BlElementGeometryProperty new geometry:
		  (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #properties }
BlElementPropertyExampleDemo >> heightProperty [

	<sampleInstance>
	^ BlElementLayoutVerticalResizerProperty new exact: 100
]

{ #category : #'examples - demo' }
BlElementPropertyExampleDemo >> propertyCleanUp [

	<sampleInstance>
	| backgroundProperty |
	backgroundProperty := self backgroundProperty.

	^ BlElement new
		  layout: (BlLinearLayout horizontal cellSpacing: 10);
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical matchParent ];
		  addChildren: {
				  (BlElement new
					   layout: (BlLinearLayout vertical cellSpacing: 10);
					   constraintsDo: [ :c |
						   c horizontal fitContent.
						   c vertical matchParent ];
					   addChildren: {
							   (BlTextElement new
								    text: 'Add background property' asRopedText;
								    border: (BlBorder paint: Color veryLightGray width: 1);
								    padding: (BlInsets all: 5);
								    labelMeasurement;
								    geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								    when: BlClickEvent do: [ :anEvent |
									    (anEvent currentTarget parent parent childWithId:
											     #targetElement) properties addProperty:
											    backgroundProperty ]).

							   (BlTextElement new
								    text: 'Remove background property' asRopedText;
								    border: (BlBorder paint: Color veryLightGray width: 1);
								    padding: (BlInsets all: 5);
								    labelMeasurement;
								    geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								    when: BlClickEvent do: [ :anEvent |
									    (anEvent currentTarget parent parent childWithId:
											     #targetElement) properties removeProperty:
											    backgroundProperty ]) }).

				  (BlElement new
					   id: #targetElement;
					   size: 200 @ 100;
					   border: (BlBorder paint: Color veryLightGray width: 2)) }
]

{ #category : #properties }
BlElementPropertyExampleDemo >> widthProperty [

	<sampleInstance>
	^ BlElementLayoutHorizontalResizerProperty new exact: 200
]

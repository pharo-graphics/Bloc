"
# Element property explanation
When dealing with properties of a visual element we often find ourselves in a situation when some properties should be propagated to children or should be resolved in a local context (`pt` units), in a context of the direct parent (`em` units) or even in a global context of the whole scene graph (`rem` units). In some othercases properties can be added, removed or changed multiple times per frame. Ideally, we would like to actually modify element's state at most once per frame. {{gtClass:BlElementProperty}} helps us to do exactly that.
## Understanding properties with status
{{gtClass:BlElementProperty}} is independent from the {{gtClass:BlElement}}, which allows us to store properties separately or even share between multiple elements. While this being a useful property it does not fascilitate an ability to track if a property is applied on a specific element. This is were {{gtClass:BlElementPropertyWithStatus}} decorator comes into play. It wraps around element property and adds a status flag: `applied`, `just added` or `to be removed`.
The status flag is an elegant approach to the performance optimization problem. When switching element styles it is common that properties are removed and then added back (with the same or maybe a different value).
As an example let's consider the background of an element. Here is what roughly happens when the background is changed from black to white color:
1) Convert {{gtClass:Color}} to {{gtClass:BlBackground}}
2) Perform a comparison of the current {{gtMethod:BlElement>>#background}} with the new one and do nothing if they are equal.
3) Change the background inst.var value to the new one and request an element to redraw.
If for example the background is changed back from white to black within the same frame the element should perform the same 3 operations, so in total it would be 6 expensive step. Visually, however, nothing changed. By adding a status flag to the property we are able to minimize the amount of expensive modifications of the element's state.
## Accessing element properties
Each element knows a collection of properties currently applied on that element ({{gtClass:BlElementCurrentProperties}}). They can be accessed by sending {{gtMethod:BlElement>>#properties}} to an element.
Consider the following element with a few properties that define its look:
{{gtExample:BlElementPropertyExplanation>>#elementWithMultipleProperties|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
Sending {{gtMethod:BlElement>>#properties}} reveals what properties are currently applied:
{{gtExample:BlElementPropertyExplanation>>#elementWithMultipleProperties|codeExpanded=false|previewExpanded=true|previewShow=#gtPropertiesFor:|previewHeight=150|noCode=true}}
## Adding and removing properties
An instance of {{gtClass:BlElementProperty}} can be added to any arbitrary element by sending {{gtMethod:BlElementCurrentProperties>>#addProperty:}} and removed by sending {{gtMethod:BlElementCurrentProperties>>#removeProperty:}} to the collection of properties previously obtained with the help of {{gtMethod:BlElement>>#properties}}. From here `Bloc` will take care of the rest. Please note, that adding and removing properties does not have an immediate effect, all modifications done to the properties are batched and performed as part of the {{gtClass:BlSpaceFramePropertiesPhase}}.
## Properties clean up after themselves
Each property knows how to apply itself on an element ({{gtMethod:BlElementProperty>>#applyOnElement:}}) and how to clean up after itself ({{gtMethod:BlElementProperty>>#cleanUpOnElement:}}). Both methods are optional and users do not have to override them, however, it is preferable to provide both implementations when applicable.
As an example let's take a {{gtClass:BlElementBackgroundProperty}} which implements both methods:
{{gtExample:BlElementPropertyExplanation>>#backgroundProperty}}
Click on the buttons to the left from the rectangular element to see what happens when the background property is added and then removed from an element:
{{gtExample:BlElementPropertyExplanation>>#propertyCleanUp|codeExpanded=false|previewExpanded=true|previewHeight=150|previewShow=#gtLiveFor:}}

"
Class {
	#name : #BlElementPropertyExample,
	#superclass : #BlExampleTest,
	#category : 'Bloc-Tests'
}

{ #category : #properties }
BlElementPropertyExample >> backgroundProperty [

	<sampleInstance>
	^ BlElementBackgroundProperty new background: (Color gray alpha: 0.2)
]

{ #category : #properties }
BlElementPropertyExample >> borderProperty [

	<sampleInstance>
	^ BlElementBorderProperty new border:
		  (BlBorder paint: Color veryLightGray width: 2)
]

{ #category : #examples }
BlElementPropertyExample >> elementWithMultipleProperties [

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
BlElementPropertyExample >> geometryProperty [

	<sampleInstance>
	^ BlElementGeometryProperty new geometry:
		  (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #properties }
BlElementPropertyExample >> heightProperty [

	<sampleInstance>
	^ BlElementLayoutVerticalResizerProperty new exact: 100
]

{ #category : #examples }
BlElementPropertyExample >> propertyCleanUp [

	<sampleInstance>
	<demo>
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
BlElementPropertyExample >> widthProperty [

	<sampleInstance>
	^ BlElementLayoutHorizontalResizerProperty new exact: 200
]

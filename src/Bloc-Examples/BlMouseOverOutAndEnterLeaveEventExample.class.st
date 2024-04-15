"
# Mouse over/out and enter/leave events

In this explanation we will take a look at what happens when mouse moves between elements and what is the difference between two families of mouse events: `enter/leave` and `over/out`.

### Quick comparison:
*(hover elements below to see the difference)*
{{gtExample:BlMouseOverOutAndEnterLeaveEventExplanation>>#quickComparison|noCode=true|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=250}}

### `BlMouseEnterEvent` and `BlMouseLeaveEvent`

If you are looking for the simplest way to detect when a user hovers an element with the mouse use a combination of `BlMouseEnterEvent` and `BlMouseLeaveEvent`.
They trigger when the mouse pointer enters/leaves the element:
*(mouse your mouse over the preview element below)*
{{gtExample:BlMouseOverOutAndEnterLeaveEventExplanation>>#basicMouseEnterAndLeave|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=240}}

`BlMouseEnterEvent` and `BlMouseLeaveEvent` are sent directly (`dispatched`) to the element, ignoring any mouse transitions inside the element, therefore both mouse enter and leave events do not bubble. In the example below, notice how parent container does not receive mouse leave event when mouse transitions between children:
{{gtExample:BlMouseOverOutAndEnterLeaveEventExplanation>>#mouseEnterAndLeaveConsumed|noCode=true|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=240}}

### `BlMouseOverEvent` and `BlMouseOutEvent`

Similar to the mouse enter but a bit more advanced, `BlMouseOverEvent` occurs when a mouse pointer comes over an element, and `BlMouseOutEvent` – when it leaves:
{{gtExample:BlMouseOverOutAndEnterLeaveEventExplanation>>#basicMouseOverAndOut|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=240}}

An important feature of mouseout – it triggers, when the pointer moves from an element to its descendant, e.g. from #parent to #child. It also means that mouse over/out events bubble.
In the example below, notice how parent container receives mouse out event when mouse transitions from it to deeper child elements:
{{gtExample:BlMouseOverOutAndEnterLeaveEventExplanation>>#mouseOverAndOutConsumed|noCode=true|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=240}}

"
Class {
	#name : #BlMouseOverOutAndEnterLeaveEventExample,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Examples-Documentation'
}

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> basicMouseEnterAndLeave [

	<sampleInstance>
	<demo>
	| aContainer |
	aContainer := self elementWithoutChildren.

	aContainer addEventHandler: (BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ :anEvent | self markElement: anEvent currentTarget ]).

	aContainer addEventHandler: (BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ :anEvent | self unmarkElement: anEvent currentTarget ]).

	^ aContainer
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> basicMouseOverAndOut [

	<sampleInstance>
	<demo>
	| aContainer |
	aContainer := self elementWithoutChildren.

	aContainer addEventHandler: (BlEventHandler
			 on: BlMouseOverEvent
			 do: [ :anEvent | self markElement: anEvent currentTarget ]).

	aContainer addEventHandler: (BlEventHandler
			 on: BlMouseOutEvent
			 do: [ :anEvent | self unmarkElement: anEvent currentTarget ]).

	^ aContainer
]

{ #category : #'examples - element' }
BlMouseOverOutAndEnterLeaveEventExample >> elementWithChildren [

	<sampleInstance>
	<demo>
	| aContainer aChildA aChildB |
	aContainer := self elementWithoutChildren.

	aChildA := BlElement new
		           background: Color white;
		           effect: self shadow;
		           position: 30 @ 50;
		           size: 100 @ 100.

	aChildB := BlElement new
		           background: Color white;
		           effect: self shadow;
		           position: 170 @ 50;
		           size: 100 @ 100.

	aContainer addChild: aChildA as: #left.
	aContainer addChild: aChildB as: #right.

	^ aContainer
]

{ #category : #'examples - element' }
BlMouseOverOutAndEnterLeaveEventExample >> elementWithoutChildren [

	<sampleInstance>
	<demo>
	| aContainer |
	aContainer := BlElement new
		              background: Color white;
		              effect: self shadow;
		              position: 50 @ 50;
		              size: 300 @ 200.

	^ aContainer
]

{ #category : #private }
BlMouseOverOutAndEnterLeaveEventExample >> markElement: anElement [
	anElement
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color red width: 2)
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> mouseEnterAndLeaveConsumed [

	<sampleInstance>
	<demo>
	| anElement aMouseEnterHandler aMouseLeaveHandler |
	aMouseEnterHandler := BlEventHandler
		                      on: BlMouseEnterEvent
		                      do: [ :anEvent |
			                      anEvent consume.
			                      anEvent currentTarget background:
				                      Color veryVeryLightGray.
			                      anEvent currentTarget border:
				                      (BlBorder paint: Color red width: 2) ].

	aMouseLeaveHandler := BlEventHandler
		                      on: BlMouseLeaveEvent
		                      do: [ :anEvent |
			                      anEvent consume.
			                      anEvent currentTarget background: Color white.
			                      anEvent currentTarget border: BlBorder empty ].

	anElement := self elementWithChildren.
	anElement withAllChildrenBreadthFirst do: [ :eachElement |
		eachElement
			addEventHandler: aMouseEnterHandler;
			addEventHandler: aMouseLeaveHandler ].

	^ anElement
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> mouseEnterAndLeaveNotConsumed [

	<sampleInstance>
	<demo>
	| anElement aMouseEnterHandler aMouseLeaveHandler |
	aMouseEnterHandler := BlEventHandler
		                      on: BlMouseEnterEvent
		                      do: [ :anEvent |
		                      self markElement: anEvent currentTarget ].

	aMouseLeaveHandler := BlEventHandler
		                      on: BlMouseLeaveEvent
		                      do: [ :anEvent |
		                      self unmarkElement: anEvent currentTarget ].

	anElement := self elementWithChildren.
	anElement withAllChildrenBreadthFirst do: [ :eachElement |
		eachElement
			addEventHandler: aMouseEnterHandler;
			addEventHandler: aMouseLeaveHandler ].

	^ anElement
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> mouseOverAndOutConsumed [

	<sampleInstance>
	<demo>
	| anElement aMouseOverHandler aMouseOutHandler |
	aMouseOverHandler := BlEventHandler
		                     on: BlMouseOverEvent
		                     do: [ :anEvent |
			                     anEvent consume.
			                     anEvent currentTarget background:
				                     Color veryVeryLightGray.
			                     anEvent currentTarget border:
				                     (BlBorder paint: Color red width: 2) ].

	aMouseOutHandler := BlEventHandler
		                    on: BlMouseOutEvent
		                    do: [ :anEvent |
			                    anEvent consume.
			                    anEvent currentTarget background: Color white.
			                    anEvent currentTarget border: BlBorder empty ].

	anElement := self elementWithChildren.
	anElement withAllChildrenBreadthFirst do: [ :eachElement |
		eachElement
			addEventHandler: aMouseOverHandler;
			addEventHandler: aMouseOutHandler ].

	^ anElement
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> mouseOverAndOutNotConsumed [

	<sampleInstance>
	<demo>
	| anElement aMouseOverHandler aMouseOutHandler |
	aMouseOverHandler := BlEventHandler
		                     on: BlMouseOverEvent
		                     do: [ :anEvent |
			                     anEvent currentTarget background:
				                     Color veryVeryLightGray.
			                     anEvent currentTarget border:
				                     (BlBorder paint: Color red width: 2) ].

	aMouseOutHandler := BlEventHandler
		                    on: BlMouseOutEvent
		                    do: [ :anEvent |
			                    anEvent currentTarget background: Color white.
			                    anEvent currentTarget border: BlBorder empty ].

	anElement := self elementWithChildren.
	anElement withAllChildrenBreadthFirst do: [ :eachElement |
		eachElement
			addEventHandler: aMouseOverHandler;
			addEventHandler: aMouseOutHandler ].

	^ anElement
]

{ #category : #'test - events' }
BlMouseOverOutAndEnterLeaveEventExample >> quickComparison [

	<sampleInstance>
	<demo>
	| aContainer |
	aContainer := BlElement new
		              layout: (BlGridLayout new
				               columnCount: 2;
				               cellSpacing: 15);
		              constraintsDo: [ :c |
			              c horizontal fitContent.
			              c vertical fitContent ];
		              addChildren: {
				              (BlTextElement new
					               text:
						               ('Mouse enter/leave' asRopedText foreground:
								                Color gray);
					               constraintsDo: [ :c |
						               c grid horizontal alignCenter.
						               c grid vertical alignCenter ]).
				              (BlTextElement new
					               text:
						               ('Mouse over/out' asRopedText foreground:
								                Color gray);
					               constraintsDo: [ :c |
						               c grid horizontal alignCenter.
						               c grid vertical alignCenter ]).

				              (self mouseEnterAndLeaveConsumed margin:
					               (BlInsets left: 20 right: 20)).
				              (self mouseOverAndOutConsumed margin:
					               (BlInsets left: 20 right: 20)) }.

	^ aContainer
]

{ #category : #private }
BlMouseOverOutAndEnterLeaveEventExample >> shadow [
	<sampleInstance>
	^ BlGaussianShadowEffect color: (Color black alpha: 0.5) width: 7 offset: 2@2
]

{ #category : #private }
BlMouseOverOutAndEnterLeaveEventExample >> unmarkElement: anElement [
	anElement
		background: Color white;
		border: BlBorder empty
]

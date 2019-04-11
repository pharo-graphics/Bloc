"
I contain examples of how one can add support of selection.

1) open example
2) Press and drag with the mouse as if you would select something on your computer desktop
"
Class {
	#name : #BlSelectionHandlerExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Selection'
}

{ #category : #examples }
BlSelectionHandlerExamples class >> grid [
	<script: 'self grid'>
	| space element |
	
	element := self new containerWithOneGridAndVisualHandler.
	
	space := BlSpace new.
	space extent: 800@600.
	space root addChild: element.
	space show
]

{ #category : #examples }
BlSelectionHandlerExamples class >> gridRow [
	<script: 'self gridRow'>
	| space element |
	
	element := self new containerWithThreeGridsAndVisualHandler.
	
	space := BlSpace new.
	space extent: 955@600.
	space root addChild: element.
	space show
]

{ #category : #'instance creation' }
BlSelectionHandlerExamples >> cell [
	<gtExample>
	
	^ BlElement new
		size: 75@75;
		background: Color random paler;
		addEventHandlerOn: BlElementSelectionAcquiredEvent
			do: [ :anEvent | anEvent target border: (BlBorder builder width: 2; paint: Color blue; build)  ];
		addEventHandlerOn: BlElementSelectionLostEvent
			do: [ :anEvent | anEvent target border: BlBorder empty ]
]

{ #category : #'instance creation' }
BlSelectionHandlerExamples >> container [
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white
]

{ #category : #examples }
BlSelectionHandlerExamples >> containerWithOneGrid [
	<gtExample>
	
	^ self container addChild: self gridWith11Cells
]

{ #category : #examples }
BlSelectionHandlerExamples >> containerWithOneGridAndVisualHandler [
	<gtExample>
	
	^ self containerWithOneGrid addEventHandler: self visualHandler
]

{ #category : #examples }
BlSelectionHandlerExamples >> containerWithThreeGrids [
	<gtExample>
	
	^ self container
		addChild: self threeGrids
]

{ #category : #examples }
BlSelectionHandlerExamples >> containerWithThreeGridsAndVisualHandler [
	<gtExample>
	
	^ self containerWithThreeGrids addEventHandler: self visualHandler
]

{ #category : #'instance creation' }
BlSelectionHandlerExamples >> grid [
	<gtExample>
	
	^ BlElement new
		background: Color veryVeryLightGray;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ];
		layout: BlGridLayout vertical;
		layoutDo: [ :l | l cellSpacing: 20; rowCount: 5 ]
]

{ #category : #examples }
BlSelectionHandlerExamples >> gridWith11Cells [
	<gtExample>
	
	^ self grid
		addChildren: ((1 to: 11) collect: [:i | self cell ]);
		yourself
]

{ #category : #examples }
BlSelectionHandlerExamples >> threeGrids [
	<gtExample>
	
	^ self container
		layout: BlGridLayout horizontal;
		layoutDo: [ :l | l cellSpacing: 10 ];
		addChildren: { self gridWith11Cells . self gridWith11Cells . self gridWith11Cells }
]

{ #category : #'instance creation' }
BlSelectionHandlerExamples >> visualHandler [
	<gtExample>
	
	^ BlVisualSelectionHandler new
]

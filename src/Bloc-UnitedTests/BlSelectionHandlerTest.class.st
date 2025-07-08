"
I have been automatically converted and probably manually tweaked from BlSelectionHandlerExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlSelectionHandlerTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Selection'
}

{ #category : #'instance creation' }
BlSelectionHandlerTest class >> grid [
	<script: 'self grid'>

	| space element |
	element := self new testContainerWithOneGridAndVisualHandler.
	
	space := BlSpace new.
	space extent: 800@600.
	space root addChild: element.
	space show
]

{ #category : #'instance creation' }
BlSelectionHandlerTest class >> gridRow [
	<script: 'self gridRow'>

	| space element |
	element := self new testContainerWithThreeGridsAndVisualHandler.
	
	space := BlSpace new.
	space extent: 955@600.
	space root addChild: element.
	space show
]

{ #category : #metadata }
BlSelectionHandlerTest >> originClassName [
	"This test was generated from..."
	^ 'BlSelectionHandlerExamples'
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testCell [

	^ BlElement new
		  extent: 75 @ 75;
		  background: Color random paler;
		  addEventHandlerOn: BlElementSelectionAcquiredEvent
			  do: [ :anEvent |
				  anEvent currentTarget border: (BlBorder builder
						   width: 2;
						   paint: Color blue;
						   build) ];
		  addEventHandlerOn: BlElementSelectionLostEvent
			  do: [ :anEvent | anEvent currentTarget border: BlBorder empty ];
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testContainer [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  background: Color white;
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testContainerWithOneGrid [

	^ self testContainer
		  addChild: self testGridWith11Cells;
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testContainerWithOneGridAndVisualHandler [

	^ self testContainerWithOneGrid
		  addEventHandler: self testVisualHandler;
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testContainerWithThreeGrids [

	^ self testContainer
		  addChild: self testThreeGrids;
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testContainerWithThreeGridsAndVisualHandler [

	^ self testContainerWithThreeGrids
		  addEventHandler: self testVisualHandler;
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testGrid [

	^ BlElement new
		  background: Color veryVeryLightGray;
		  constraintsDo: [ :c | 
			  c horizontal fitContent.
			  c vertical matchParent ];
		  layout: BlGridLayout vertical;
		  layoutDo: [ :l | 
			  l
				  cellSpacing: 20;
				  rowCount: 5 ];
			yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testGridWith11Cells [

	^ self testGrid
		  addChildren: ((1 to: 11) collect: [ :i | self testCell ]);
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testThreeGrids [

	^ self testContainer
		  layout: BlGridLayout horizontal;
		  layoutDo: [ :l | l cellSpacing: 10 ];
		  addChildren: { 
				  self testGridWith11Cells.
				  self testGridWith11Cells.
				  self testGridWith11Cells };
		  yourself
]

{ #category : #'smoke tests' }
BlSelectionHandlerTest >> testVisualHandler [

	^ BlVisualSelectionHandler new
]

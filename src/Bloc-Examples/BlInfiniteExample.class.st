"
I contain exmples of infinite element
"
Class {
	#name : #BlInfiniteExample,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #examples }
BlInfiniteExample class >> classes [
	<script: 'self classes'>

	self
		openInWindow: self new classesList
		named: 'All classes'
		extent: 400@600
]

{ #category : #examples }
BlInfiniteExample class >> colors [
	<script: 'self colors'>

	self
		openInWindow: self new colorsList
		named: 'All colors'
		extent: 400@600
]

{ #category : #examples }
BlInfiniteExample class >> exampleClassesMultiple [
	| dataSource space1 list1 space2 list2 |
	
	dataSource := BlInfiniteExampleClassesDataSource new.

	list1 := BlInfiniteExampleElement new
		dataSource: dataSource;
		background: Color paleBlue;
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	space1 := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses (1)'.
	space1 root addChild: list1.
	
	list2 := BlInfiniteExampleElement new
		dataSource: dataSource;
		background: Color paleRed;
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	space2 := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses (2)'.
	space2 root addChild: list2.
	
	
	space1 show.
	space2 show.
]

{ #category : #examples }
BlInfiniteExample class >> exampleGallery [
	| space list container header headerText |
	space := BlSpace new
		extent: 400 @ 650;
		title: 'Gallery'.

	container := BlElement new
		layout: BlFrameLayout new;
		background: Color veryDarkGray;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			"will take 100% of the parent"
			c linear weight: 1 ];
		yourself.	

	header := BlElement new
		layout: BlLinearLayout vertical;
		"effect: (BlBlurBelowEffect radius: 4);"
		background: (Color black alpha: 0.6);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c frame vertical alignTop.
			c padding: (BlInsets top: 15 right: 0 bottom: 15 left: 0) ];
		yourself.

	headerText := BlTextElement new
		text: ((BlRopedText string: 'bloc gallery')
			attributes: { 
				BrTextForegroundAttribute paint: (Color white alpha: 0.8).
				BrFontSizeAttribute size: 20.
				BrFontWeightAttribute weight: 50.
				BrFontFamilyAttribute named: 'Helvetica Neue'
			};
			yourself);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignCenter.
			c linear vertical alignCenter ];
		yourself.
		
	header addChild: headerText.
	
	list := BlInfiniteExampleGalleryListElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	container addChildren: { list . header }.
	space root addChild: container.
	space root background: Color veryVeryDarkGray.
	space root layout: BlLinearLayout horizontal.
	space root layout weightSum: 1.
"	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show
]

{ #category : #examples }
BlInfiniteExample class >> text [
	"Does not work"
	| space list container |
	space := BlSpace new
		extent: 550 @ 750;
		title: 'Infinite list example'.

	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	list := BlInfiniteExampleTextListElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	container addChildren: { list }.
	space root addChild: container.
	space root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space root
		addChild: (BlBenchmarkConsole on:space).
	space show
]

{ #category : #'example - classes' }
BlInfiniteExample >> classesDataSource [
	<gtExample>
	
	^ BlInfiniteExampleClassesDataSource new
]

{ #category : #'example - classes' }
BlInfiniteExample >> classesList [
	<gtExample>
	
	^ self verticalList
		dataSource: self classesDataSource
]

{ #category : #'example - colors' }
BlInfiniteExample >> colorsDataSource [
	<gtExample>
	
	^ BlInfiniteExampleColorsDataSource new
]

{ #category : #'example - colors' }
BlInfiniteExample >> colorsList [
	<gtExample>
	
	^ self verticalList
		dataSource: self colorsDataSource
]

{ #category : #'instance creation' }
BlInfiniteExample >> verticalList [
	<gtExample>
	
	^ BlInfiniteExampleElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

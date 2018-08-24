Class {
	#name : #BlInfiniteLinearLayoutExamples,
	#superclass : #Object,
	#category : 'Bloc-Infinite-Examples-Linear'
}

{ #category : #examples }
BlInfiniteLinearLayoutExamples class >> exampleClasses [
	| space list container |
	space := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses'.
		
	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets top: 5) ];
		yourself.	
	
	list := BlInfiniteExampleClassesListElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	
	container addChild: list.
	
	space root addChild: container.
	"space root addChild: (BlBenchmarkLogger new)."
	"space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show
]

{ #category : #examples }
BlInfiniteLinearLayoutExamples class >> exampleClassesMultiple [
	| dataSource space1 list1 space2 list2 |
	
	dataSource := BlInfiniteExampleClassesDataSource new.

	list1 := BlInfiniteExampleClassesListElement new
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
	
	list2 := BlInfiniteExampleClassesListElement new
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
BlInfiniteLinearLayoutExamples class >> exampleColors [
	| space list container |
	space := BlSpace new
		extent: 800 @ 650;
		title: 'Infinite list example'.

	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	list := BlInfiniteExampleColorsListElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
		
	container addChildren: { list }.
	
	space root addChild: container.
	space show
]

{ #category : #examples }
BlInfiniteLinearLayoutExamples class >> exampleGallery [
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
		text: ((BrRopedText string: 'bloc gallery')
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
BlInfiniteLinearLayoutExamples class >> text [
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
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space root
		addChild: (BlBenchmarkConsole on:space).
	space show
]

"
How to:

	1) Inspect / run example
	2) Click one any cell to give it a focus (blue border should appear)
	3) Navigate with keyboard arrows (arrow up/down left/right)

"
Class {
	#name : #BlFocusExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-FocusFinder-Examples'
}

{ #category : #examples }
BlFocusExamples class >> composed [
	<script: 'self composed'>
	
	self
		openInWindow: self new composed
		named: 'Composed'
]

{ #category : #examples }
BlFocusExamples class >> flow [
	<script: 'self flow'>
	
	self
		openInWindow: self new composedFlow
		named: 'Composed flow'
]

{ #category : #examples }
BlFocusExamples class >> grid [
	<script: 'self grid'>
	
	self
		openInWindow: self new grid
		named: 'Grid'
]

{ #category : #examples }
BlFocusExamples class >> horizontal [
	<script: 'self horizontal'>
	
	self
		openInWindow: self new linearHorizontal
		named: 'Horizontal'
]

{ #category : #opening }
BlFocusExamples class >> openInWindow: anElement named: aTitleString [
	| aSpace |

	aSpace := BlSpace new
		title: aTitleString.

	aSpace root
		addChild: anElement;
		yourself.

	aSpace pulse.
	aSpace extent: anElement extent.
	
	aSpace show
]

{ #category : #examples }
BlFocusExamples class >> vertical [
	<script: 'self vertical'>
	
	self
		openInWindow: self new linearVertical
		named: 'Vertical'
]

{ #category : #examples }
BlFocusExamples >> cell [
	<gtExample>
	
	^ BlElement new
		extent: 50 @ 30;
		background: Color random muchLighter darker;
		addEventHandlerOn: BlFocusEvent
			do: [ :anEvent | anEvent target border: (BlBorder paint: Color blue width: 2) ];
		addEventHandlerOn: BlBlurEvent
			do: [ :anEvent | anEvent target border: BlBorder empty ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | 
			anEvent consume.
			anEvent target requestFocus ];
		yourself
]

{ #category : #examples }
BlFocusExamples >> composed [
	<gtExample>
	| container children |

	children := (1 to: 5) collect: [ :index |
		| grid gridChildren |
		gridChildren := (1 to: 20 atRandom + 6) collect: [ :i | self cell ].

		grid := BlElement new.
		grid focusability: BlFocusability after.
		grid background: Color white.
		grid margin: (BlInsets all: 5).
		grid layout: BlGridLayout new.
		grid layout columnCount: (gridChildren size sqrt + 1) rounded.
		grid layout cellSpacing: 2.
		grid constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
		grid addChildren: gridChildren.
		grid addEventHandlerOn: BlFocusEvent do: [ :anEvent | anEvent target border: (BlBorder paint: Color blue width: 2) ].
		grid addEventHandlerOn: BlBlurEvent do: [ :anEvent | anEvent target border: BlBorder empty ].
		grid ].

	container := BlElement new.
	container background: Color veryVeryLightGray.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #examples }
BlFocusExamples >> composedFlow [
	<gtExample>
	| container children |

	children := (1 to: 5) collect: [ :index |
		| grid gridChildren |
		gridChildren := (1 to: 20 atRandom + 6)
			collect: [ :i | self cell extent: ((30 @ 30) + (50 atRandom @ 10 atRandom)); margin: (BlInsets all: 2) ].

		grid := BlElement new.
		grid focusability: BlFocusability after.
		grid background: Color white.
		grid margin: (BlInsets all: 5).
		grid layout: BlFlowLayout new.
		grid constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical fitContent ].
		grid addChildren: gridChildren.
		grid addEventHandlerOn: BlFocusEvent do: [ :anEvent | anEvent target border: (BlBorder paint: Color blue width: 2) ].
		grid addEventHandlerOn: BlBlurEvent do: [ :anEvent | anEvent target border: BlBorder empty ].
		grid ].

	container := BlElement new.
	container background: Color veryVeryLightGray.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #examples }
BlFocusExamples >> grid [
	<gtExample>
	| container children |

	children := (1 to: 50) collect: [ :index |
		self cell ].

	container := BlElement new.
	container layout: BlGridLayout new.
	container layout columnCount: 8.
	container layout cellSpacing: 5.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #examples }
BlFocusExamples >> linearHorizontal [
	<gtExample>
	| container children |

	children := (1 to: 10) collect: [ :index |
		self cell extent: 40@200; margin: (BlInsets all: 2)  ].

	container := BlElement new.
	container layout: BlLinearLayout horizontal.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #examples }
BlFocusExamples >> linearVertical [
	<gtExample>
	| container children |

	children := (1 to: 10) collect: [ :index |
		self cell extent: 200@50; margin: (BlInsets all: 2)  ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

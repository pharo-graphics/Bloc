Class {
	#name : #BlGridMeasurer,
	#superclass : #Object,
	#instVars : [
		'element',
		'layout'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #margin }
BlGridMeasurer >> alignedMarginOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading [

	^ self layout alignment marginOf: aChildElement in: self layout isHorizontal: isHorizontal isLeading: isLeading
]

{ #category : #margin }
BlGridMeasurer >> cellSpacingOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading [
	"Return cell spacing around aChildElement for the side defined by isHorizontal and isLeading.
	First of all I determine if cell is on the edge and use it as additional parameter to allow more precise
	computation.
	@see cellSpacingOf:isAtEdge:isHorizontal:isLeading: for more info."
	<return: #Number>

	| spec axis span isAtEdge |
	spec := isHorizontal
		ifTrue: [ aChildElement constraints grid horizontal spec ]
		ifFalse: [ aChildElement constraints grid vertical spec ].

	axis := self layout axis: isHorizontal.
	span := spec span.
	
	isAtEdge := isLeading
		ifTrue: [ span first = 1 ]
		ifFalse: [ span last = axis count ].

	^ self layout cellSpacingOf: aChildElement isAtEdge: isAtEdge isHorizontal: isHorizontal isLeading: isLeading
]

{ #category : #measure }
BlGridMeasurer >> improvedMeasureChild: aChildElement parentSpec: anExtentSpec [
	| horizontal spec span axis locations cellSize childSize|
	horizontal := self layout orientation isHorizontal.
	spec := horizontal
		ifTrue: [ aChildElement constraints grid horizontal spec ]
		ifFalse: [ aChildElement constraints grid vertical spec ].

	(spec absoluteAlignment: horizontal) isFill
		ifFalse: [ ^ self ].

	span := spec span.
	axis := self layout axis: horizontal.
	locations := axis locations.
	cellSize := (locations at: span last) - (locations at: span first).
	childSize := cellSize - (self totalMarginOf: aChildElement isHorizontal: horizontal).
	horizontal
		ifTrue: [ self
			measureChild: aChildElement
			parentSpec: anExtentSpec
			widthResizer:(BlLayoutResizer exact: childSize)
			heightResizer: aChildElement constraints vertical resizer ]
		ifFalse: [ self
			measureChild: aChildElement
			parentSpec: anExtentSpec
			widthResizer: aChildElement constraints horizontal resizer
			heightResizer: (BlLayoutResizer exact: childSize) ]
]

{ #category : #accessing }
BlGridMeasurer >> layout [
	^ layout
]

{ #category : #accessing }
BlGridMeasurer >> layout: aGridLayout [
	layout := aGridLayout
]

{ #category : #margin }
BlGridMeasurer >> marginOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading [
	| margin |

	margin := isHorizontal
		ifTrue: [ isLeading ifTrue: [ aChildElement margin left ] ifFalse: [ aChildElement margin right ] ]
		ifFalse: [ isLeading ifTrue: [ aChildElement margin top ] ifFalse: [ aChildElement margin bottom ] ].
	
	^ margin <= 0
		ifTrue: [ self cellSpacingOf: aChildElement isHorizontal: isHorizontal isLeading: isLeading ]
		ifFalse: [ margin ]
]

{ #category : #measure }
BlGridMeasurer >> measureChild: anElement parentSpec: anExtentSpec widthResizer: widthResizer heightResizer: heightResizer [
	| childWidthSpec childHeightSpec |

	childWidthSpec := self layout
		measurementSpecFor: anExtentSpec widthSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: true)
		resizer: (widthResizer ifMatchParent: [ BlLayoutResizer exact: 0 ]).

	childHeightSpec := self layout
		measurementSpecFor: anExtentSpec heightSpec
		usedSize: (self totalMarginOf: anElement isHorizontal: false)
		resizer: (heightResizer ifMatchParent: [ BlLayoutResizer exact: 0 ]).
		
	anElement measure: (childWidthSpec @ childHeightSpec)
]

{ #category : #measure }
BlGridMeasurer >> measureChildren: anElement parentSpec: anExtentSpec isFirstPass: isFirstPass [

	anElement children accountedByLayout
		select: [ :child | child visibility shouldMeasure ]
		thenDo: [ :child | isFirstPass
			ifTrue: [ self naiveMeasureChild: child parentSpec: anExtentSpec ]
			ifFalse: [ self improvedMeasureChild: child parentSpec: anExtentSpec ] ]
]

{ #category : #measure }
BlGridMeasurer >> measurementOf: anElement isHorizontal: isHorizontal [
	<return: #Number>
	
	^ isHorizontal
		ifTrue: [ anElement measuredWidth ]
		ifFalse: [ anElement measuredHeight ]
]

{ #category : #measure }
BlGridMeasurer >> measurementWithMarginOf: aChildElement isHorizontal: isHorizontal [
	<return: #Number>

	aChildElement visibility shouldLayout
		ifFalse: [ ^ 0 ].

	^ (self measurementOf: aChildElement isHorizontal: isHorizontal) + (self totalMarginOf: aChildElement isHorizontal: isHorizontal)
]

{ #category : #measure }
BlGridMeasurer >> naiveMeasureChild: aChildElement parentSpec: anExtentSpec [

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthResizer: aChildElement constraints horizontal resizer
		heightResizer: aChildElement constraints vertical resizer
]

{ #category : #margin }
BlGridMeasurer >> totalMarginOf: aChildElement isHorizontal: isHorizontal [

	^ (self alignedMarginOf: aChildElement isHorizontal: isHorizontal isLeading: true) + (self alignedMarginOf: aChildElement isHorizontal: isHorizontal isLeading: false)
]

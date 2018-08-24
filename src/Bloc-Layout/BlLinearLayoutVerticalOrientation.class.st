Class {
	#name : #BlLinearLayoutVerticalOrientation,
	#superclass : #BlLinearLayoutOrientation,
	#category : 'Bloc-Layout-Linear-Utilities'
}

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> breadthMode [
	^ self layout cache widthMode
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> breadthProperties: anElement [
	^ anElement constraints horizontal
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> breadthSpec [
	^ self layout cache widthMeasureSpec
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> extentBreadth: breadth lengthSpec: length [
	^ breadth @ length
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [
	^ BlExtentMeasurementSpec new
		widthSpec: breadthSpec;
		heightSpec: lengthSpec
]

{ #category : #testing }
BlLinearLayoutVerticalOrientation >> isVertical [
	^ true
]

{ #category : #layout }
BlLinearLayoutVerticalOrientation >> layout: anElement in: aRectangle [
	|top right bottom left majorBounds elementInnerBounds|
	"Layout subnodes vertically in column one by one
	based on previously measured extent"
	
	top := anElement insets top.
	left := anElement insets left. 
	right := left.
	bottom := top.

	anElement children accountedByLayout do: [ :child | 
		right := right max: child measuredWidth + (child outsets width max: 0).
		bottom := bottom + child measuredHeight + (child outsets height max: 0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement padding inset: anElement boundsInLocal.
	majorBounds = elementInnerBounds ifFalse: [
		| translation |
		translation := self layout verticalAlignment translationOf: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: translation ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.

	anElement children accountedByLayout
		inject: left @ top
		into: [ :origin :child |
			| childBounds childMarginBounds childConstraints |
			childConstraints := child constraints linear.
			childBounds := origin + (child outsets topLeft max: 0@0) extent: child measuredExtent.
			childMarginBounds := origin extent: child measuredExtent + (child outsets extent max: 0@0).  
			
			self layout horizontalAlignment ifNotNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: elementInnerBounds width @ child measuredHeight.
				translation := (self layout horizontalAlignment directed: self layout direction) translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].

			self layout horizontalAlignment ifNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: elementInnerBounds width @ child measuredHeight.
				translation := (childConstraints horizontal alignment directed: self layout direction) translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].
			
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds.
			"translating origin vertically down for next subnode"
			origin x @(origin y + child measuredHeight + (child outsets height max: 0)) ]
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> lengthLinearProperties: aChildElement [
	^ aChildElement constraints linear vertical
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> lengthMode [
	^ self layout cache heightMode
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> lengthProperties: aChildElement [
	^ aChildElement constraints vertical
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> lengthSpec [
	^ self layout cache heightMeasureSpec
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> marginBreadth: anElement [
	^ anElement outsets width
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> marginLength: anElement [
	^ anElement outsets height
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> measureChildWithMargin: child parentSpec: anExtentMeasurementSpec breadthUsed: breadthUsed lengthUsed: lengthUsed [
	self layout
		measureChildWithMargins: child
		parentSpec: anExtentMeasurementSpec
		widthUsed: breadthUsed
		heightUsed: lengthUsed
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> measuredBreadth: anElement [
	^ anElement measuredWidth
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> measuredLength: anElement [
	^ anElement measuredHeight
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> minimalBreadth: anElement [
	^ anElement constraints minWidth
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> minimalLength: anElement [
	^ anElement constraints minHeight
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> paddingBreadth: anElement [
	^ anElement insets width
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> paddingLength: anElement [
	^ anElement insets height
]

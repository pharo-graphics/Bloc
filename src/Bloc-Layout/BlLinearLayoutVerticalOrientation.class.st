Class {
	#name : #BlLinearLayoutVerticalOrientation,
	#superclass : #BlLinearLayoutOrientation,
	#category : #'Bloc-Layout-Linear-Utilities'
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
BlLinearLayoutVerticalOrientation >> breadthSpec: anExtentSpec [
	^ anExtentSpec widthSpec
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> extentBreadth: breadth lengthSpec: length [
	^ breadth @ length
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [

	^ BlExtentMeasurementSpec
		  widthSpec: breadthSpec
		  heightSpec: lengthSpec
]

{ #category : #factory }
BlLinearLayoutVerticalOrientation >> inverted [

	^ BlLinearLayoutHorizontalOrientation new
]

{ #category : #testing }
BlLinearLayoutVerticalOrientation >> isVertical [
	^ true
]

{ #category : #layout }
BlLinearLayoutVerticalOrientation >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	|top right bottom left majorBounds elementInnerBounds turn theLayeredChildren |
	"Layout subnodes vertically in column one by one
	based on previously measured extent"
	
	top := anElement padding top.
	left := anElement padding left. 
	right := left.
	bottom := top.

	theLayeredChildren := anElement children accountedByLayout.

	self layout direction
		with: theLayeredChildren
		do: [ :child | 
		right := right max: child measuredWidth + (child margin width max: 0.0).
		bottom := bottom + child measuredHeight + (child margin height max: 0.0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement padding inset: anElement boundsInLocal.
	majorBounds = elementInnerBounds ifFalse: [
		| translation |
		translation := (self layout verticalAlignment directed: self layout direction) translationOf: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: translation ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.

	turn := 1.
	self layout direction
		with: anElement children accountedByLayout
		inject: left @ top
		into: [ :origin :child |
			| childBounds childMarginBounds childConstraints interspacing |
			childConstraints := child constraints linear.
			childBounds := origin + (child margin topLeft max: 0.0@0.0) extent: child measuredExtent.
			childMarginBounds := origin extent: child measuredExtent + (child margin extent max: 0.0@0.0).  
			
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
			
			childBounds := childBounds translateBy: (0.0 @ self layout cellSpacing).
			
			interspacing := turn = 1
			                ifTrue: [ 0.0 ]
			                ifFalse: [ self layout interspace ].
			interspacing > 0.0 ifTrue: [ childBounds := childBounds translateBy: 0 @ interspacing ].
			
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds context: aBlElementBoundsUpdateContext.
			"translating origin vertically down for next subnode"
			turn := turn + 1.
			origin x @(origin y + child measuredHeight + self layout cellSpacing + (child margin height max: 0.0)) ]
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
BlLinearLayoutVerticalOrientation >> lengthSpec: anExtentSpec [
	^ anExtentSpec heightSpec
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> marginBreadth: anElement [

	^ anElement margin width
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> marginLength: anElement [

	^ anElement margin height
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

	^ anElement padding width
]

{ #category : #orientation }
BlLinearLayoutVerticalOrientation >> paddingLength: anElement [

	^ anElement padding height
]

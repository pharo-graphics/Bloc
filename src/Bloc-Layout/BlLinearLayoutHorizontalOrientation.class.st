Class {
	#name : #BlLinearLayoutHorizontalOrientation,
	#superclass : #BlLinearLayoutOrientation,
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> breadthMode [
	^ self layout cache heightMode
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> breadthProperties: anElement [
	^ anElement constraints vertical
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> breadthSpec: anExtentSpec [
	^ anExtentSpec heightSpec
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> extentBreadth: breadth lengthSpec: length [
	^ length @ breadth
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [

	^ BlExtentMeasurementSpec
		  widthSpec: lengthSpec
		  heightSpec: breadthSpec
]

{ #category : #factory }
BlLinearLayoutHorizontalOrientation >> inverted [

	^ BlLinearLayoutVerticalOrientation new
]

{ #category : #testing }
BlLinearLayoutHorizontalOrientation >> isHorizontal [
	^ true
]

{ #category : #layout }
BlLinearLayoutHorizontalOrientation >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	|top right bottom left majorBounds elementInnerBounds theLayeredChildren turn |
	"Layout subnodes vertically in column one by one
	based on previousely measured extent"

	top := anElement padding top.
	left := anElement padding left. 
	right := left.
	bottom := top.

	theLayeredChildren := anElement children accountedByLayout.

	self layout direction
		with: theLayeredChildren
		do: [ :child |
			right := right + child measuredWidth + (child margin width max: 0.0).
			bottom := bottom max: child measuredHeight + (child margin height max: 0.0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement padding inset: anElement boundsInLocal.
	majorBounds = elementInnerBounds ifFalse: [
		| translation |
		translation := (self layout horizontalAlignment directed: self layout direction) translationOf: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: translation ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.
	
	turn := 1.
	self layout direction
		with: theLayeredChildren
		inject: left @ top
		into: [ :origin :child |
			| childBounds childMarginBounds childConstraints interspacing |
			childConstraints := child constraints linear.
			childBounds := origin + (child margin topLeft max: 0.0@0.0) extent: child measuredExtent.
			childMarginBounds := origin extent: child measuredExtent + (child margin extent max: 0.0@0.0).  

			self layout verticalAlignment ifNotNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := self layout verticalAlignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].

			self layout verticalAlignment ifNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := childConstraints vertical alignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].
			
			childBounds := childBounds translateBy: (self layout cellSpacing @ 0.0).
			interspacing := turn = 1
			                ifTrue: [ 0.0 ]
			                ifFalse: [ self layout interspace ].
			interspacing > 0.0 ifTrue: [ childBounds := childBounds translateBy: interspacing @ 0.0 ].
			
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds context: aBlElementBoundsUpdateContext.
			"translating origin horizontally right for next subnode"
			turn := turn + 1.
			(origin x + child measuredWidth + (child margin width max: 0.0) + self layout cellSpacing) @ origin y ]
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> lengthLinearProperties: aChildElement [
	^ aChildElement constraints linear horizontal
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> lengthMode [
	^ self layout cache widthMode
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> lengthProperties: aChildElement [
	^ aChildElement constraints horizontal
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> lengthSpec: anExtentSpec [
	^ anExtentSpec widthSpec
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> marginBreadth: anElement [

	^ anElement margin height
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> marginLength: anElement [

	^ anElement margin width
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> measureChildWithMargin: child parentSpec: anExtentMeasurementSpec breadthUsed: breadthUsed lengthUsed: lengthUsed [
	self layout
		measureChildWithMargins: child
		parentSpec: anExtentMeasurementSpec
		widthUsed: lengthUsed
		heightUsed: breadthUsed
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> measuredBreadth: anElement [
	^ anElement measuredHeight
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> measuredLength: anElement [
	^ anElement measuredWidth
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> minimalBreadth: anElement [
	^ anElement constraints minHeight
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> minimalLength: anElement [
	^ anElement constraints minWidth
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> paddingBreadth: anElement [

	^ anElement padding height
]

{ #category : #orientation }
BlLinearLayoutHorizontalOrientation >> paddingLength: anElement [

	^ anElement padding width
]

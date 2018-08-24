Class {
	#name : #BlGridLayoutImpl,
	#superclass : #BlLayout,
	#instVars : [
		'horizontalAxis',
		'verticalAxis',
		'lastLayoutParamsHashCode',
		'measurer',
		'layout'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #'instance creation' }
BlGridLayoutImpl class >> on: aGridLayout [
	^ self new
		layout: aGridLayout;
		yourself
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> adjust: aMeasurementSpec by: delta [

	^ BlMeasurementSpec new
		size: (aMeasurementSpec size ifNotNil: [ :size | size + delta ]);
		mode: aMeasurementSpec mode
]

{ #category : #accessing }
BlGridLayoutImpl >> alignment [
	^ layout alignment
]

{ #category : #'private accessing' }
BlGridLayoutImpl >> axis: isHorizontal [

	^ isHorizontal 
		ifTrue: [ horizontalAxis ]
		ifFalse: [ verticalAxis ]
]

{ #category : #accessing }
BlGridLayoutImpl >> cellSpacing [
	^ layout cellSpacing
]

{ #category : #computation }
BlGridLayoutImpl >> cellSpacingOf: aChildElement isAtEdge: isAtEdge isHorizontal: isHorizontal isLeading: isLeading [
	"Return cell spacing around aChildElement at the side defined by isAtEdge, isHorizontal and isLeading.
	isAtEdge is a boolean whose value is true if cell is located on the grid's edge, meaning that it
		is first (index = 1) or last (index = N + 1) in the group of cell (in the row or column).
	isHorizontal is a boolean whose value is true if spacing needs to be returned for horizontal
		side which is left or right.
	isLeading is a boolean value whose value is true if desired cell side is the first along orientation
		define by isHorizontal, e.g. if isHorizontal is true and isLeading is true than it is left side,
		if isHorizontal is true and isLeading is false side should be right. The same applies for
		vertical orientation, top side if isLeading is true and bottom if false.
	Default implementation uses cell spacing value defined in GridLayout and makes sure that spacing
	between cells is equal to spacing between cell and grid's border.
	Override me if you want to have custom cell spacing"
	<return: #Number>

	^ isAtEdge
		ifTrue: [ self cellSpacing ]
		ifFalse: [ self cellSpacing / 2.0 ]
]

{ #category : #private }
BlGridLayoutImpl >> checkConsistency: anElement [

	lastLayoutParamsHashCode
		ifNil: [
			self validateLayoutParams: anElement.
			lastLayoutParamsHashCode := self constraintsHashCode: anElement ]
		ifNotNil: [ 
			lastLayoutParamsHashCode ~= (self constraintsHashCode: anElement) ifTrue: [ 
				Warning signal: 'Layout constraints were modified between layout operations'.	
				self invalidateStructure.
				self checkConsistency: anElement ] ]
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> clip: range isDefined: isDefined count: count [
	"We treat range Interval as open: start <= x < end"
	| size min |
	size := range size - 1.
	count = 0
		ifTrue: [ ^ size ].

	min := isDefined
		ifTrue: [ (range first min: count) - 1 ]
		ifFalse: [ 0 ].

	^ size min: count - min
]

{ #category : #accessing }
BlGridLayoutImpl >> columnCount: aNumber [
	horizontalAxis count: aNumber
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> constraintsHashCode: anElement [
	
	^ anElement children accountedByLayout inject: 1 into: [ :hash :child |
		child visibility isGone
			ifTrue: [ hash ]
			ifFalse: [ hash bitXor: child constraints hash ] ]
]

{ #category : #initialization }
BlGridLayoutImpl >> defaultMeasurer [
	^ BlGridMeasurer new
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> fill: anArray from: fromIndex to: toIndex with: value [
	"To index exclusive"
	
	"Make sure that fromIndex is within bounds"
	((fromIndex <= toIndex) and: [
			(fromIndex > 0 and: [ anArray isNotEmpty ]) or: [
				fromIndex = 0 and: [
					anArray isEmpty ] ] ] )
		ifFalse: [
			SubscriptOutOfBounds
				signalFor: fromIndex
				lowerBound: (anArray ifEmpty: [ 0 ] ifNotEmpty:  [ 1 ])
				upperBound: anArray size + 1
				in: anArray ].
			
	"Make sure that toIndex is within bounds"
	((toIndex <= (anArray size + 1)) and: [
			(toIndex > 1) or: [
				toIndex = 1 and: [
					anArray isEmpty ] ] ] )
		ifFalse: [
			SubscriptOutOfBounds
				signalFor: toIndex
				lowerBound: (anArray ifEmpty: [ 0 ] ifNotEmpty:  [ 1 ])
				upperBound: anArray size + 1
				in: anArray ].
	
	"Do nothing if empty"
	anArray
		ifEmpty: [
			self
				assert: [ (fromIndex + 1) = toIndex and: [ fromIndex = 0 ] ]
				description: [ 'From must be equal 0 and to equal 1 if array is empty' ].
			^ self ].
	
	anArray
		atAll: (fromIndex to: toIndex - 1)
		put: value
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> fits: anArray from: fromIndex to: toIndex with: value [
	"Return true if value fits inside array within interval
	fromIndex to toIndex exclusive, false otherwise.
	Value 'fits' in array if it is less or equal to all elements
	in array within specified range.
	fromIndex must be greater than 0"
	<return: #Boolean>

	self
		assert: [ fromIndex > 0 ]
		description: [ 'From index must be greater than 0' ].

	((toIndex - 1) > anArray size)
		ifTrue: [ ^ false ].

	^ (fromIndex to: (toIndex - 1)) allSatisfy: [ :i | (anArray at: i) <= value ]
]

{ #category : #initialization }
BlGridLayoutImpl >> initialize [
	super initialize.

	verticalAxis := BlGridLayoutAxis new horizontal: false.
	horizontalAxis := BlGridLayoutAxis new horizontal: true.
	measurer := self defaultMeasurer
]

{ #category : #'private invalidate' }
BlGridLayoutImpl >> invalidateStructure [
	lastLayoutParamsHashCode := nil.
	horizontalAxis invalidateStructure.
	verticalAxis invalidateStructure.
	self invalidateValues
]

{ #category : #'private invalidate' }
BlGridLayoutImpl >> invalidateValues [
	horizontalAxis invalidateValues.
	verticalAxis invalidateValues
]

{ #category : #accessing }
BlGridLayoutImpl >> layout: aGridLayout [
	layout := aGridLayout
]

{ #category : #layout }
BlGridLayoutImpl >> layout: anElement in: aRectangle [
	| targetWidth targetHeight paddingLeft paddingTop paddingRight paddingBottom hLocations vLocations|
	
	self checkConsistency: anElement.
	
	targetWidth := aRectangle width.
	targetHeight := aRectangle height.
	
	paddingLeft := anElement insets left.
	paddingRight := anElement insets right.
	paddingTop := anElement insets top.
	paddingBottom := anElement insets bottom.
	
	horizontalAxis applyLayoutIn: targetWidth - paddingLeft - paddingRight.
	verticalAxis applyLayoutIn: targetHeight - paddingTop - paddingBottom.
	
	hLocations := horizontalAxis locations.
	vLocations := verticalAxis locations.
	
	anElement children accountedByLayout withIndexDo: [ :child :index |
		child visibility shouldLayout ifTrue: [ 
			| columnSpec rowSpec colSpan rowSpan locationBounds cellWidth cellHeight pWidth pHeight hAlign vAlign boundsX boundsY gravityOffsetX gravityOffsetY
			leftMargin topMargin rightMargin bottomMargin sumMarginsX sumMarginsY alignmentOffsetX alignmentOffsetY width height dx cx cy |
			columnSpec := child constraints grid horizontal spec.
			rowSpec := child constraints grid vertical spec.

			colSpan := columnSpec span.
			rowSpan := rowSpec span.

			locationBounds := (hLocations at: colSpan first) @ (vLocations at: rowSpan first)
				corner: ((hLocations at: colSpan last) @ (vLocations at: rowSpan last)).

			cellWidth := locationBounds width.
			cellHeight := locationBounds height.
			
			pWidth := measurer measurementOf: child isHorizontal: true.
			pHeight := measurer measurementOf: child isHorizontal: false.
			
			hAlign := columnSpec absoluteAlignment: true.
			vAlign := rowSpec absoluteAlignment: false.
			
			boundsX := horizontalAxis groupBounds at: index.
			boundsY := verticalAxis groupBounds at: index.
			
			gravityOffsetX := hAlign gravityOffset: child cellDelta: cellWidth - (boundsX size: true).
			gravityOffsetY := vAlign gravityOffset: child cellDelta: cellHeight - (boundsY size: true).
			
			leftMargin := self measurer alignedMarginOf: child isHorizontal: true isLeading: true.
			topMargin := self measurer alignedMarginOf: child isHorizontal: false isLeading: true.
			rightMargin := self measurer alignedMarginOf: child isHorizontal: true isLeading: false.
			bottomMargin := self measurer alignedMarginOf: child isHorizontal: false isLeading: false.

			sumMarginsX := leftMargin + rightMargin.
			sumMarginsY := topMargin + bottomMargin.

			alignmentOffsetX := boundsX offset: child alignment: hAlign size: pWidth + sumMarginsX.
			alignmentOffsetY := boundsY offset: child alignment: vAlign size: pHeight + sumMarginsY.
			
			width := hAlign sizeInCell: child viewSize: pWidth cellSize: cellWidth - sumMarginsX.
			height := vAlign sizeInCell: child viewSize: pHeight cellSize: cellHeight - sumMarginsY.
			
			dx := locationBounds left + gravityOffsetX + alignmentOffsetX.
			
			cx := paddingLeft + leftMargin + dx.
			cy := paddingTop + locationBounds top + gravityOffsetY + alignmentOffsetY + topMargin.
			
			 (width ~= child measuredWidth or: [ height ~= child measuredHeight ])
				ifTrue: [ child measure: (BlExtentMeasurementSpec exact: width @ height) ].
				
			child applyLayoutIn: (cx @ cy extent: width @ height) ] ]
]

{ #category : #measure }
BlGridLayoutImpl >> measure: anElement with: anExtentSpec [
	| widthSpec heightSpec hPadding vPadding widthSpecSansPadding heightSpecSansPadding widthSansPadding heightSansPadding measuredWidth measuredHeight |

	horizontalAxis element: anElement.
	horizontalAxis layout: self.
	verticalAxis element: anElement.
	verticalAxis layout: self.
	measurer layout: self.

	widthSpec := anExtentSpec widthSpec.
	heightSpec := anExtentSpec heightSpec.
	
	self invalidateStructure.
	self checkConsistency: anElement.
	self invalidateValues.

	hPadding := anElement insets width.
	vPadding := anElement insets height.
	
	widthSpecSansPadding := self adjust: widthSpec by: hPadding negated.
	heightSpecSansPadding := self adjust: heightSpec by: vPadding negated.

	self measurer measureChildren: anElement parentSpec: anExtentSpec isFirstPass: true.

	self orientation isHorizontal
		ifTrue: [
			widthSansPadding := horizontalAxis measure: widthSpecSansPadding.
			self measurer
				measureChildren: anElement
				parentSpec: widthSpecSansPadding @ heightSpecSansPadding
				isFirstPass: false.
			heightSansPadding := verticalAxis measure: heightSpecSansPadding ]
		ifFalse: [ 
			heightSansPadding := verticalAxis measure: heightSpecSansPadding.
			self measurer
				measureChildren: anElement
				parentSpec: widthSpecSansPadding @ heightSpecSansPadding
				isFirstPass: false.
			widthSansPadding := horizontalAxis measure: widthSpecSansPadding ].
	
	measuredWidth := (widthSansPadding + hPadding).
	measuredHeight := (heightSansPadding + vPadding).

	anElement measuredExtent: (anExtentSpec sizeFor: measuredWidth @ measuredHeight)
]

{ #category : #'private accessing' }
BlGridLayoutImpl >> measurer [
	^ measurer
]

{ #category : #accessing }
BlGridLayoutImpl >> orientation [
	^ layout orientation
]

{ #category : #accessing }
BlGridLayoutImpl >> rowCount: aNumber [
	verticalAxis count: aNumber
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> setGroup: child row: row span: rowSpan col: col span: colSpan [
	| childConstraints |
	childConstraints := child constraints grid.
	childConstraints vertical specSpan: (row to: row + rowSpan).
	childConstraints horizontal specSpan: (col to: col + colSpan)
]

{ #category : #private }
BlGridLayoutImpl >> validateChildConstraints: aChildElement [
	| childConstraints |
	childConstraints := aChildElement constraints grid.
	"we need to convert match parent mode to something that fits grid layout"
	aChildElement constraints horizontal resizer
		ifMatchParent: [
			childConstraints horizontal spec weight isZero
				ifTrue: [ childConstraints horizontal weight: 1 ].
			childConstraints horizontal specAlignment: BlGridAlignment fill ].
	
	aChildElement constraints vertical resizer
		ifMatchParent: [
			childConstraints vertical spec weight isZero
				ifTrue: [ childConstraints vertical weight: 1 ].
			childConstraints vertical specAlignment: BlGridAlignment fill ]
]

{ #category : #private }
BlGridLayoutImpl >> validateLayoutParams: anElement [
	| horizontal axis count major minor maxSizes |
	horizontal := self orientation isHorizontal.
	axis := self axis: horizontal.
	count := (axis definedCount ~= UNDEFINED)
		ifTrue: [ axis definedCount ]
		ifFalse: [ 0 ].

	major := 1.
	minor := 1.
	maxSizes := Array new: count withAll: 1.

	anElement children accountedByLayout do: [ :child |
		| majorSpec majorRange majorWasDefined majorSpan minorSpec minorRange minorWasDefined minorSpan childConstraints |
		childConstraints := child constraints grid.
		self validateChildConstraints: child.
		
		majorSpec := horizontal
			ifTrue: [ childConstraints vertical spec ]
			ifFalse: [ childConstraints horizontal spec ].

		majorRange := majorSpec span.
		majorWasDefined := majorSpec startDefined.
		"majorRange interval is open, so reduce size by one"
		majorSpan := majorRange size - 1.
		majorWasDefined
			ifTrue: [ major := majorRange first ].
		
		minorSpec := horizontal
			ifTrue: [ childConstraints horizontal spec ]
			ifFalse: [ childConstraints vertical spec ].
		minorRange := minorSpec span.
		minorWasDefined := minorSpec startDefined.
		minorSpan := self clip: minorRange isDefined: minorWasDefined count: count.
		minorWasDefined
			ifTrue: [ minor := minorRange first ].
	
		count ~= 0 ifTrue: [
			"If row or column count is not defined we need to calculate it"
			(majorWasDefined and: [ minorWasDefined ] ) ifFalse: [ 
				[ self fits: maxSizes from: minor to: minor + minorSpan with: major ] whileFalse: [ 
					minorWasDefined
						ifTrue: [ major := major + 1 ]
						ifFalse: [ (minor + minorSpan <= count)
							ifTrue: [ minor := minor + 1 ]
							ifFalse: [ minor := 1. major := major + 1 ] ] ] ].
			self fill: maxSizes from: minor to: minor + minorSpan with: major + majorSpan ].

		horizontal
			ifTrue: [ self setGroup: child row: major span: majorSpan col: minor span: minorSpan ]
			ifFalse: [ self setGroup: child row: minor span: minorSpan col: major span: majorSpan ].

		minor := minor + minorSpan ]
]

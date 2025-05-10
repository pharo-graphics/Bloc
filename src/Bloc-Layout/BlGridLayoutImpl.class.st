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
	#category : #'Bloc-Layout-Grid-Utilities'
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
	"Return an object that represents a horizontal axis if isHorizontal is true and vertical axis otherwise"
	<return: #BlGridLayoutAxis>

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
		is first (index = 0) or last (index = N) in the group of cell (in the row or column).
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
BlGridLayoutImpl >> clip: aBlGridLayoutInterval isDefined: isDefined count: count [
	"Logic to avert infinite loops by ensuring that the cells can be placed somewhere."
	<return: #Number>
	| size min |

	size := aBlGridLayoutInterval size.
	
	count isZero
		ifTrue: [ ^ size ].

	min := isDefined
		ifTrue: [ (aBlGridLayoutInterval min min: count) ]
		ifFalse: [ 0 ].

	^ size min: count - min
]

{ #category : #accessing }
BlGridLayoutImpl >> columnCount: aNumber [
	horizontalAxis count: aNumber
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> constraintsHashCode: anElement [
	
	^ anElement children accountedByLayout inject: 1 into: [ :hash :child | hash bitXor: child constraints hash ]
]

{ #category : #initialization }
BlGridLayoutImpl >> defaultMeasurer [
	^ BlGridMeasurer new
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> fill: anArray from: fromIndex to: toIndex with: aValue [

	| aLength start end |
	aLength := anArray size.
	start := fromIndex min: aLength.
	end := toIndex min: aLength.
	
	start > end ifTrue: [
		self error: ('fromIndex({1}) > toIndex({2})' format: { fromIndex. toIndex }) ].
	
	start + 1 to: end do: [:index | anArray at: index put: aValue ]
]

{ #category : #'private utilities' }
BlGridLayoutImpl >> fits: anArray from: fromIndex to: toIndex with: value [
	"Return true if value fits inside array within interval
	fromIndex to toIndex exclusive, false otherwise.
	Value 'fits' in array if it is less or equal to all elements
	in array within specified range.
	fromIndex must be greater than 0"

	(toIndex > anArray size) ifTrue: [ ^ false ].

	fromIndex to: toIndex - 1 do: [ :index |
		(anArray at: index + 1) <= value ifFalse: [ ^ false ] ].

	^ true
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
BlGridLayoutImpl >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	| targetWidth targetHeight paddingLeft paddingTop paddingRight paddingBottom hLocations vLocations|
	
	measurer layout
		ifNil: [ ^ self ].
	
	self checkConsistency: anElement.
	
	targetWidth := aRectangle width.
	targetHeight := aRectangle height.
	
	paddingLeft := anElement padding left.
	paddingRight := anElement padding right.
	paddingTop := anElement padding top.
	paddingBottom := anElement padding bottom.
	
	horizontalAxis applyLayoutWithin: targetWidth - paddingLeft - paddingRight.
	verticalAxis applyLayoutWithin: targetHeight - paddingTop - paddingBottom.
	
	hLocations := horizontalAxis locations.
	vLocations := verticalAxis locations.
	
	anElement children accountedByLayout withIndexDo: [ :child :index |
		| columnSpec rowSpec colSpan rowSpan locationBounds cellWidth cellHeight pWidth pHeight hAlign vAlign boundsX boundsY gravityOffsetX gravityOffsetY
		leftMargin topMargin rightMargin bottomMargin sumMarginsX sumMarginsY alignmentOffsetX alignmentOffsetY width height dx cx cy |

		columnSpec := child constraints grid columnSpec.
		rowSpec := child constraints grid rowSpec.

		colSpan := columnSpec span.
		rowSpan := rowSpec span.

		locationBounds := (hLocations at: colSpan min + 1) @ (vLocations at: rowSpan min + 1)
			corner: ((hLocations at: colSpan max + 1) @ (vLocations at: rowSpan max + 1)).

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
			ifTrue: [
				child measure:
					(BlExtentMeasurementSpec
						widthSpec: (BlMeasurementSpec exact: width asFloat)
						heightSpec: (BlMeasurementSpec exact: height asFloat)) ].

		child
			applyLayoutIn: (BlBounds left: cx top: cy width: width height: height)
			context: aBlElementBoundsUpdateContext ]
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

	hPadding := anElement padding width.
	vPadding := anElement padding height.
	
	widthSpecSansPadding := self adjust: widthSpec by: hPadding negated.
	heightSpecSansPadding := self adjust: heightSpec by: vPadding negated.

	anElement ignoreRequestLayoutDuring: [
		self measurer measureChildren: anElement parentSpec: anExtentSpec isFirstPass: true ].

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

	anElement measuredExtent:
		(anExtentSpec sizeForWidth: measuredWidth height: measuredHeight)
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
	childConstraints vertical specSpan:
		(BlGridLayoutInterval min: row max: row + rowSpan).
	childConstraints horizontal specSpan:
		(BlGridLayoutInterval min: col max: col + colSpan)
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
	"install default indices for cells that don't define them"
	| isHorizontal anAxis aCount major minor maxSizes |

	isHorizontal := self orientation isHorizontal.
	anAxis := self axis: isHorizontal.

	aCount := (anAxis definedCount ~= UNDEFINED)
		ifTrue: [ anAxis definedCount ]
		ifFalse: [ 0 ].

	major := 0.
	minor := 0.
	maxSizes := Array new: aCount withAll: 0.

	anElement children accountedByLayout do: [ :child |
		| majorSpec majorRange majorWasDefined majorSpan minorSpec minorRange minorWasDefined minorSpan childConstraints |
		childConstraints := child constraints grid.
		self validateChildConstraints: child.
		
		majorSpec := isHorizontal
			ifTrue: [ childConstraints rowSpec ] "rowSpec - defines vertical characteristics"
			ifFalse: [ childConstraints columnSpec ] "columnSpec - defines horizontal characteristics".

		majorRange := majorSpec span.
		majorWasDefined := majorSpec startDefined.
		majorSpan := majorRange size.
		majorWasDefined
			ifTrue: [ major := majorRange min ].
		
		minorSpec := isHorizontal
			ifTrue: [ childConstraints columnSpec ]
			ifFalse: [ childConstraints rowSpec ].
	
		minorRange := minorSpec span.
		minorWasDefined := minorSpec startDefined.
		minorSpan := self clip: minorRange isDefined: minorWasDefined count: aCount.
		minorWasDefined
			ifTrue: [ minor := minorRange min ].
	
		aCount ~= 0 ifTrue: [
			"If row or column count is not defined we need to calculate it"
			(majorWasDefined and: [ minorWasDefined ] ) ifFalse: [ 
				[ self fits: maxSizes from: minor to: minor + minorSpan with: major ] whileFalse: [ 
					minorWasDefined
						ifTrue: [ major := major + 1 ]
						ifFalse: [ (minor + minorSpan <= aCount)
							ifTrue: [ minor := minor + 1 ]
							ifFalse: [ minor := 0. major := major + 1 ] ] ] ].
			self fill: maxSizes from: minor to: minor + minorSpan with: major + majorSpan ].

		isHorizontal
			ifTrue: [ self setGroup: child row: major span: majorSpan col: minor span: minorSpan ]
			ifFalse: [ self setGroup: child row: minor span: minorSpan col: major span: majorSpan ].

		minor := minor + minorSpan ]
]

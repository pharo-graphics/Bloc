layout
layout: anElement in: aRectangle
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
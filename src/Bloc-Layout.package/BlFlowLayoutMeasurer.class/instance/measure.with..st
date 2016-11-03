measure
measure: anElement with: anExtentSpec
	| lastLine contentLength contentBreadth parentLength parentBreadth totalContentWidth totalContentHeight |
	
	children removeAll.
	lines removeAll.
	
	anElement managedChildrenDo: [ :aChildElement |
		| child childConstraints childType |
		childConstraints := aChildElement constraints flow.
		layout measureChildWithMargins: aChildElement parentSpec: anExtentSpec.

		childType := childConstraints display isFloating
			ifTrue: [ BlFlowLayoutFloatingChild ]
			ifFalse: [ BlFlowLayoutInlineChild ].

		child := childType measurer: self element: aChildElement.
		child width: aChildElement measuredWidth.
		child height: aChildElement measuredHeight.
		child newLine: childConstraints isNewLine.
		child alignment: childConstraints alignment.
		child weight: childConstraints weight.
		child display: childConstraints display.
		child margin: aChildElement constraints margin.
		children add: child ].

	widthMode := anExtentSpec widthSpec.
	heightMode := anExtentSpec heightSpec.

	maxWidth := (widthMode size ifNil: [ Float infinity ]) - anElement padding width.
	maxHeight := (heightMode size ifNil: [ Float infinity ]) - anElement padding height.
	
	checkCanFit := self lengthMode isUnspecified not.
	
	self fillLines: lines with: children.
	self calculatePositions: lines.
	
	lastLine := lines last.
	
	contentLength := lines inject: 0 into: [ :aContentLength :aLine | aContentLength max: aLine length ].
	contentBreadth := lastLine startBreadth + lastLine breadth.
	
	parentLength := self size: contentLength max: self maxLength for: anExtentSpec widthSpec.
	parentBreadth := self size: contentBreadth max: self maxBreadth for: anExtentSpec heightSpec.
	
	self alignLines: lines within: parentLength @ parentBreadth.
	lines do: [ :aLine | self measureLine: aLine ].

	totalContentWidth := anElement padding width.
	totalContentHeight := anElement padding height.
	
	self orientation isHorizontal ifTrue: [ 
		totalContentWidth := totalContentWidth + contentLength.
		totalContentHeight := totalContentHeight + contentBreadth ].
	self orientation isVertical ifTrue: [ 
		totalContentWidth := totalContentWidth + contentBreadth.
		totalContentHeight := totalContentHeight + contentLength ].
	
	anElement measuredExtent: (anExtentSpec sizeFor: totalContentWidth @ totalContentWidth)
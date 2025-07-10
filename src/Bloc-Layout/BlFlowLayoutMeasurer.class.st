Class {
	#name : #BlFlowLayoutMeasurer,
	#superclass : #Object,
	#instVars : [
		'layout',
		'children',
		'lines',
		'orientation',
		'maxWidth',
		'maxHeight',
		'widthMode',
		'heightMode',
		'checkCanFit'
	],
	#category : #'Bloc-Layout-Flow-Utilities'
}

{ #category : #'instance creation' }
BlFlowLayoutMeasurer class >> for: aLayout [
	^ self new
		layout: aLayout;
		yourself
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> alignLine: aLine [
	| totalWeight lastChild excessLength excessOffset |
	aLine isEmpty
		ifTrue: [ ^ self ].

	totalWeight := aLine children
		inject: 0
		into: [ :aTotalWeight :aChild | aTotalWeight + aChild weight ].

	lastChild := aLine children last.
	excessLength := aLine length - (lastChild length + lastChild spacingLength + lastChild startLength).
	excessOffset := 0.

	aLine children do: [ :aChild |
		| extraLength childLength childBreadth allowedBounds origin alignment |
		extraLength := totalWeight isZero
			ifTrue: [ excessLength / aLine children size ]
			ifFalse: [ excessLength * aChild weight / totalWeight ].
		childLength := aChild length + aChild spacingLength.
		childBreadth := aChild breadth + aChild spacingBreadth.
	
		alignment := aChild alignment.
		alignment := alignment directed: self direction.
		alignment := self orientation isHorizontal
			ifTrue: [ alignment ]
			ifFalse: [ alignment inverted ].

		allowedBounds := 0 @ excessOffset extent: (childLength + extraLength) @ aLine breadth.
		origin := alignment translationOf: (0 @ excessOffset extent: childLength @ childBreadth) in: allowedBounds.
		excessOffset := excessOffset + extraLength.
		
		aChild startLength: origin x + aChild startLength.
		aChild startBreadth: origin y ]
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> alignLinesWithin: anExtent [
	| lastLine excessBreadth excessOffset |
	lines
		ifEmpty: [ ^ self ].

	lastLine := lines last.
	excessBreadth := (anExtent y - (lastLine breadth + lastLine startBreadth)) max: 0.
	excessOffset := 0.
	
	lines do: [ :aLine |
		| extraBreadth lineLength lineBreadth allowedBounds origin alignment |
		extraBreadth := excessBreadth / lines size.
		lineLength := aLine length.
		lineBreadth := aLine breadth.
		
		alignment := layout alignment.
		alignment := self orientation isHorizontal
			ifTrue: [ alignment ]
			ifFalse: [ 
				self direction isLeftToRight 
					ifTrue: [ alignment inverted ]
					ifFalse: [ alignment swap ] ].
		alignment := alignment directed: self direction.
	
		allowedBounds := 0 @ excessOffset extent: anExtent x @ (lineBreadth + extraBreadth).
		origin := alignment translationOf: (0 @ excessOffset extent: lineLength @ lineBreadth) in: allowedBounds.
		
		excessOffset := excessOffset + extraBreadth.
		aLine startLength: aLine startLength + origin x.
		aLine startBreadth: aLine startBreadth + origin y.
		
		self alignLine: aLine ]
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> beHorizontal [
	orientation := BlFlowLayoutHorizontal new
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> beVertical [
	orientation := BlFlowLayoutVertical new
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> breadthMode [
	^ self orientation breadthModeOf: self
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> calculatePositions [
	
	"lines inject: 0 into: [ :totalBreadth :aLine |
		aLine startBreadth: totalBreadth.
		aLine children inject: 0 into: [ :totalLength :aChild |
			aChild startLength: totalLength.
			totalLength + aChild length + aChild spacingLength ].
		totalBreadth + aLine breadth ]"
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> direction [
	^ layout direction
]

{ #category : #measure }
BlFlowLayoutMeasurer >> fillChildrenFor: anElement with: anExtentSpec [

	children removeAll.

	anElement children accountedByLayout do: [ :aChildElement |
		| child childConstraints childType |
		childConstraints := aChildElement constraints flow.
		layout
			measureChildWithMargins: aChildElement
			parentSpec: anExtentSpec.

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
		children add: child ]
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> fillLines [

	| currentLine floatingQueue lineLength availableSpace totalBreadth currentSpaceIndex currentSpace |
	currentLine := BlFlowLayoutLine for: self.
	lines removeAll.
	lines add: currentLine.

	floatingQueue := SortedCollection sortBlock: [ :a :b |
		                 a startLength < b startLength ].
	lineLength := 0.
	totalBreadth := 0.
	availableSpace := BlFlowLayoutLineSpace new
		                  initializeFor: floatingQueue
		                  maxLength: self maxLength.
	currentSpaceIndex := 1.
	currentSpace := availableSpace intervals at: currentSpaceIndex.

	children do: [ :aChild |
		| newLine |
		[
		lineLength + aChild totalLength > currentSpace last and: [
			currentSpaceIndex <= availableSpace intervals size ] ] whileTrue: [
			currentSpaceIndex := currentSpaceIndex + 1.
			currentSpaceIndex <= availableSpace intervals size ifTrue: [
				currentSpace := availableSpace intervals at: currentSpaceIndex.
				lineLength := currentSpace first.
				currentLine length: lineLength ] ].

		newLine := aChild isNewLine or: [
			           self isCheckCanFit and: [
				           (currentLine canFit: aChild) not ] ].
		"we create and add new line to the list making it current one"
		newLine ifTrue: [
			| previousLine |
			previousLine := currentLine.
			(previousLine children allSatisfy: [ :aLineChild |
				 aLineChild isFloating ]) ifTrue: [
				previousLine breadth: (previousLine children
						 inject: 0
						 into: [ :aTotalBreadth :aFloatingChild |
							 aTotalBreadth max: aFloatingChild totalBreadth ]) ].
			totalBreadth := totalBreadth + previousLine breadth.

			"remove obsolete floating elements here"
			floatingQueue := floatingQueue select: [ :aFloatingChild |
				                 aFloatingChild excessBreadth > 0 ].

			availableSpace := BlFlowLayoutLineSpace new
				                  initializeFor: floatingQueue
				                  maxLength: self maxLength.
			currentSpaceIndex := 1.
			currentSpace := availableSpace intervals at: currentSpaceIndex.

			currentLine := BlFlowLayoutLine for: self.
			currentLine addTo: lines.
			floatingQueue do: [ :aFloatingChild |
				aFloatingChild addToLine: currentLine ].
			currentLine startBreadth: totalBreadth.

			lineLength := 0.
			[
			(lineLength < currentSpace first or: [
				 lineLength + aChild totalLength > currentSpace last ]) and: [
				currentSpaceIndex <= availableSpace intervals size ] ] whileTrue: [
				currentSpaceIndex <= availableSpace intervals size ifTrue: [
					currentSpace := availableSpace intervals at: currentSpaceIndex.
					lineLength := currentSpace first.
					currentLine length: lineLength ].
				currentSpaceIndex := currentSpaceIndex + 1 ].
			currentSpaceIndex > 1 ifTrue: [
				currentSpaceIndex := currentSpaceIndex - 1 ] ].

		aChild addToLine: currentLine.
		aChild startLength: lineLength.
		lineLength := lineLength + aChild length + aChild spacingLength.

		aChild isFloating ifTrue: [ floatingQueue add: aChild ] ]
]

{ #category : #measure }
BlFlowLayoutMeasurer >> fillLinesFor: anElement with: anExtentSpec [

	| lastLine contentLength contentBreadth parentLength parentBreadth totalContentWidth totalContentHeight |
	widthMode := anExtentSpec widthSpec.
	heightMode := anExtentSpec heightSpec.

	maxWidth := (widthMode size ifNil: [ Float infinity ])
	            - anElement padding width.
	maxHeight := (heightMode size ifNil: [ Float infinity ])
	             - anElement padding height.

	checkCanFit := self lengthMode isUnspecified not.

	self fillLines.
	self calculatePositions.

	lastLine := lines last.
	contentLength := lines
		                 inject: 0.0
		                 into: [ :aContentLength :aLine |
		                 aContentLength max: aLine length ].
	contentBreadth := lastLine startBreadth + lastLine breadth.
	parentLength := self
		                size: contentLength
		                max: self maxLength
		                for: anExtentSpec widthSpec.
	parentBreadth := self
		                 size: contentBreadth
		                 max: self maxBreadth
		                 for: anExtentSpec heightSpec.

	self alignLinesWithin: parentLength @ parentBreadth.
	lines do: [ :aLine | self measureLine: aLine ].

	totalContentWidth := anElement padding width.
	totalContentHeight := anElement padding height.

	self orientation isHorizontal ifTrue: [
		totalContentWidth := totalContentWidth + contentLength.
		totalContentHeight := totalContentHeight + contentBreadth ].
	self orientation isVertical ifTrue: [
		totalContentWidth := totalContentWidth + contentBreadth.
		totalContentHeight := totalContentHeight + contentLength ].

	anElement measuredExtent:
		(anExtentSpec extentForWidth: totalContentWidth height: totalContentHeight)
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> heightMode [
	^ heightMode
]

{ #category : #initialization }
BlFlowLayoutMeasurer >> initialize [
	super initialize.
	
	children := OrderedCollection new.
	lines := OrderedCollection new
]

{ #category : #testing }
BlFlowLayoutMeasurer >> isCheckCanFit [
	^ checkCanFit
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> layout: aLayout [
	layout := aLayout
]

{ #category : #layout }
BlFlowLayoutMeasurer >> layout: anElement in: newBounds context: aBlElementBoundsUpdateContext [
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			| constraints left top width height |
			constraints := aChild element constraints.
			left := anElement padding left + aLine lineX + aChild inlineX + constraints margin left.
			top := anElement padding top + aLine lineY + aChild inlineY + constraints margin top.
			width := aChild width.
			height := aChild height.
			aChild element applyLayoutIn: (left @ top extent: width @ height) context: aBlElementBoundsUpdateContext ] ]
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> lengthMode [
	^ self orientation lengthModeOf: self
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> maxBreadth [
	^ self orientation maxBreadthOf: self
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> maxHeight [
	^ maxHeight
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> maxLength [
	^ self orientation maxLengthOf: self
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> maxWidth [
	^ maxWidth
]

{ #category : #measure }
BlFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	self fillChildrenFor: anElement with: anExtentSpec.
	self fillLinesFor: anElement with: anExtentSpec
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> measureLine: aLine [
	
	aLine children do: [ :aChild |
		| aRequestedExtent |
		aRequestedExtent := aChild width @ aChild height.
		aChild element measuredExtent = aRequestedExtent ifFalse: [ 
			aChild element measure: (BlExtentMeasurementSpec exact: aRequestedExtent) ] ]
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> orientation [
	^ orientation
]

{ #category : #calculating }
BlFlowLayoutMeasurer >> size: aContentSize max: aMaxContentSize for: aMeasumentSpec [

	aMeasumentSpec isUnspecified
		ifTrue: [ ^ aContentSize ].
		
	aMeasumentSpec isAtMost 
		ifTrue: [ ^ aContentSize min: aMaxContentSize ].
		
	aMeasumentSpec isExact
		ifTrue: [ ^ aMaxContentSize ].
	
	^ aContentSize
]

{ #category : #accessing }
BlFlowLayoutMeasurer >> widthMode [
	^ widthMode
]

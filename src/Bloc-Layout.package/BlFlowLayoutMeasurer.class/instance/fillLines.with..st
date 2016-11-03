calculating
fillLines: theLines with: theChildren
	| currentLine floatingQueue lineLength availableSpace totalBreadth currentSpaceIndex currentSpace |
	self flag: 'This is something horrible!!!!'.
	self flag: 'REFACTOR ME!!!'.
	self flag: 'p.s. but first cover with unit tests :)'.
	
	currentLine := BlFlowLayoutLine for: self.
	theLines add: currentLine.

	floatingQueue := SortedCollection sortBlock: [ :a :b | a startLength < b startLength ].
	lineLength := 0.
	totalBreadth := 0.
	availableSpace := BlFlowLayoutLineSpace new initializeFor: floatingQueue maxLength: self maxLength.
	currentSpaceIndex := 1.
	currentSpace := availableSpace intervals at: currentSpaceIndex.

	theChildren do: [ :aChild |
		| newLine |
		[ (lineLength + aChild totalLength > currentSpace last)
			and: [ currentSpaceIndex <= availableSpace intervals size ] ]
			whileTrue: [
				currentSpaceIndex := currentSpaceIndex + 1.
				(currentSpaceIndex <= availableSpace intervals size)
					ifTrue: [
						currentSpace := availableSpace intervals at: currentSpaceIndex.
						lineLength := currentSpace first.
						currentLine length: lineLength ] ].
		
		newLine := aChild isNewLine or: [ self isCheckCanFit and: [ (currentLine canFit: aChild) not ] ].
		"we create and add new line to the list making it current one"
		newLine ifTrue: [ 
			| previousLine |
			previousLine := currentLine.
			(previousLine children allSatisfy: [ :aLineChild | aLineChild isFloating ])
				ifTrue: [
					previousLine breadth: (previousLine children inject: 0 into: [ :aTotalBreadth :aFloatingChild |
						aTotalBreadth max: aFloatingChild totalBreadth ]) ].
			totalBreadth := totalBreadth + previousLine breadth.
			"remove obsolete floating elements here"
			floatingQueue := floatingQueue select: [ :aFloatingChild |
				aFloatingChild excessBreadth > 0 ].
			availableSpace := BlFlowLayoutLineSpace new initializeFor: floatingQueue maxLength: self maxLength.
			currentSpaceIndex := 1.
			currentSpace := availableSpace intervals at: currentSpaceIndex.
			currentLine := BlFlowLayoutLine for: self.
			currentLine addTo: theLines.
			floatingQueue do: [ :aFloatingChild | aFloatingChild addToLine: currentLine ].
			currentLine startBreadth: totalBreadth.
			
			lineLength := 0.
			[ ((lineLength < currentSpace first) or: [ lineLength + aChild totalLength > currentSpace last ])
				and: [ currentSpaceIndex <= availableSpace intervals size ] ]
			whileTrue: [
				(currentSpaceIndex <= availableSpace intervals size)
					ifTrue: [
						currentSpace := availableSpace intervals at: currentSpaceIndex.
						lineLength := currentSpace first.
						currentLine length: lineLength ].
				currentSpaceIndex := currentSpaceIndex + 1 ].
			currentSpaceIndex > 1 ifTrue: [ currentSpaceIndex := currentSpaceIndex - 1 ].
			].

		aChild addToLine: currentLine.
		aChild startLength: lineLength.
		lineLength := lineLength + aChild length + aChild spacingLength.

		aChild isFloating
			ifTrue: [ floatingQueue add: aChild ] ]
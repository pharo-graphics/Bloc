private
mergeSplit: aCollection at: anIndex
	| leftArray rightArray middle totalSize leftAmountBeforeIndex leftAmountFromCollection leftAmountAfterIndex rightAmountBeforeIndex alreadyFilledAmount alreadyFilledAmountFromCollection rightAmountFromCollection rightAmountAfterIndex |
	
	totalSize := collection size + aCollection size.
	middle := (totalSize / 2) asInteger.
	leftArray := Array new: middle.
	rightArray := Array new: totalSize - middle.
	
	leftAmountBeforeIndex := (middle min: anIndex) max: 0.
	alreadyFilledAmount := leftAmountBeforeIndex.
	leftAmountBeforeIndex > 0
		ifTrue: [ 
			leftArray
				replaceFrom: 1
				to: leftAmountBeforeIndex
				with: collection
				startingAt: 1  ].

	leftAmountFromCollection := ((middle - leftAmountBeforeIndex) min: aCollection size) max: 0.
	alreadyFilledAmountFromCollection := leftAmountFromCollection.
	leftAmountFromCollection > 0
		ifTrue: [
			leftArray
				replaceFrom: leftAmountBeforeIndex + 1
				to: leftAmountBeforeIndex + leftAmountFromCollection
				with: aCollection
				startingAt: 1 ].
	
	leftAmountAfterIndex := (middle - leftAmountBeforeIndex - leftAmountFromCollection) max: 0.
	alreadyFilledAmount := alreadyFilledAmount + leftAmountAfterIndex.
	"it is greater than zero if we can still fill left part"
	leftAmountAfterIndex > 0
		ifTrue: [ 
			leftArray
				replaceFrom: leftArray size - leftAmountAfterIndex + 1
				to: leftArray size
				with: collection
				startingAt: leftAmountBeforeIndex + 1 ].

	rightAmountBeforeIndex := (anIndex - middle) max: 0.
	rightAmountBeforeIndex > 0
		ifTrue: [ 
			rightArray
				replaceFrom: 1
				to: rightAmountBeforeIndex
				with: collection
				startingAt: alreadyFilledAmount + 1 ].
	alreadyFilledAmount := alreadyFilledAmount + rightAmountBeforeIndex.
	
	rightAmountFromCollection := (aCollection size - alreadyFilledAmountFromCollection) max: 0.
	rightAmountFromCollection > 0
		ifTrue: [
			rightArray
				replaceFrom: rightAmountBeforeIndex + 1
				to: rightAmountBeforeIndex + rightAmountFromCollection
				with: aCollection
				startingAt: alreadyFilledAmountFromCollection + 1 ].
	
	rightAmountAfterIndex := (collection size - alreadyFilledAmount) max: 0.
	rightAmountAfterIndex > 0
		ifTrue: [ 
			rightArray
				replaceFrom: rightArray size - rightAmountAfterIndex + 1
				to: rightArray size
				with: collection
				startingAt: collection size - rightAmountAfterIndex + 1 ].
	
	^ self class
		concatenate: (self class collectionRope collection: leftArray)
		and: (self class collectionRope collection: rightArray)
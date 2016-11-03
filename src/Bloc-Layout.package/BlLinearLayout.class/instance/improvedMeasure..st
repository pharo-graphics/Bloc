measure
improvedMeasure: anElement
	| currentWeightSum deltaLength |
	
	deltaLength := self cache length - self cache totalLength.
	currentWeightSum := self weightSum > 0
		ifTrue: [ self weightSum ]
		ifFalse: [ self cache totalWeight ].
	"because we perform improved measurement we need to recalculate totalLength"
	self cache totalLength: 0.
	
	anElement managedChildrenDo: [ :child |
		| marginBreadth marginLength measuredBreadth childMatchBreadth |
		marginBreadth := self orientation marginBreadth: child.
		marginLength := self orientation marginLength: child.
		"improve children that match parent along length axis"
		(self orientation lengthProperties: child) resizer isMatchParent ifTrue: [ 
			| sharedLength childBreadthSpec|
			"compute child's length it takes depending on weight"
			sharedLength := (child constraints weight * deltaLength / currentWeightSum) asFloat.
			"reduce current weight and delta length for the next iteration"
			currentWeightSum := currentWeightSum - child constraints weight.
			deltaLength := deltaLength - sharedLength.
			"take child's margin into account and check against negative values"
			sharedLength := (sharedLength - marginLength) max: 0.
			"create new width measurement spec, as we already know it (at least approximately)"
			childBreadthSpec := self
				measurementSpecFor: self orientation breadthSpec
				usedSize: (self orientation paddingBreadth: anElement) + marginBreadth
				resizer: (self orientation breadthProperties: child) resizer.
			
			"depending on anElement's length mode measure child differently"
			self orientation lengthMode isExact
				ifFalse: [
					| childLength |
					"If anElement does not know its exact length we can't tell
					what length child should have if it matches parent, so we just
					measure as it is reusing measured length from previous measuring pass"
					childLength := (self orientation measuredLength: child) + sharedLength.
					childLength := childLength max: 0.
					child measure: (self orientation
						extentSpecBreadth: childBreadthSpec
						lengthSpec: (BlMeasurementSpec new
							beExact: childLength)) ]
				ifTrue: [
					"if anElement knows height exactly we can measure
					child instantly giving it as much space as it wants"
					child measure: (self orientation 
						extentSpecBreadth: childBreadthSpec
						lengthSpec: (BlMeasurementSpec new
							beExact: (sharedLength max: 0))) ] ].
		"// End of ifMatchParent: block //"
		
		"if child matches parent along breadth axis we can not say its breadth,
		so if it is the case just use margin breadth as breadth"
		(self orientation breadthProperties: child) resizer isMatchParent
			ifFalse: [ measuredBreadth := (self orientation measuredBreadth: child) + marginBreadth ]
			ifTrue: [ measuredBreadth := marginBreadth ].
			
		self cache maxBreadth: (self cache maxBreadth max: measuredBreadth).
		childMatchBreadth := self orientation breadthMode isExact not and: [ (self orientation breadthProperties: child) resizer isMatchParent ].
				
		self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: (childMatchBreadth ifTrue: [ marginBreadth ] ifFalse: [ measuredBreadth ] ) ).
		self cache totalLength: (self cache totalLength max: (self cache totalLength + (self orientation measuredLength: child) + marginLength)).
	].
	self cache totalLength: (self cache totalLength + (self orientation paddingLength: anElement))
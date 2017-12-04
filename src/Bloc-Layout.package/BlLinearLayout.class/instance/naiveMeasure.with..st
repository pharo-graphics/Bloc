measure
naiveMeasure: anElement with: anExtentMeasurementSpec
	"First naive pass to measure children with exact dimension or those who wrap to content"

	self measuredChildren: anElement do: [ :child |
		| childMatchBreadth measuredBreadth matchingBreadth childConstraints |
		childConstraints := child constraints linear.
		"we need a local flag to know if one particular child want to match breadth of a parent.
		there is a global flag to detect if any of the children wants to match breadth"
		childMatchBreadth := false.

		"We care about weight only if child is matching parent"
		(self orientation lengthProperties: child) resizer
			ifMatchParent: [ self cache totalWeight: self cache totalWeight + childConstraints weight ].

		"Measure child during first pass if we don't skip it"
		(self shouldSkipNaiveMeasure: child)
			ifFalse: [
				self orientation 
					measureChildWithMargin: child
					parentSpec: anExtentMeasurementSpec
					breadthUsed: 0
					lengthUsed: (self cache totalWeight = 0 ifTrue: [ self cache totalLength ] ifFalse: [ 0 ]).
				"we use max: to not mess up with negative margin values (some layouts may support negative margin)"
				self cache totalLength: (self cache totalLength max: (self cache totalLength + (self orientation measuredLength: child) + (self orientation marginLength: child))) ].
		
		"update corresponding breadth matching flags if we have complicated case"
		(self needsToMatchBreadth: child) 
			ifTrue: [
				self cache matchBreadth: true.
				childMatchBreadth := true ].

		"get child's measured breadth with margin taking into account.
		if child wants to match parent measured breadth is just margin"
		measuredBreadth := self measuredBreadthWithMargin: child.

		"update max breadth of all children based on child's measured breadth.
		we will need it later for the case if parent wants to wrap content horizontally"
		self cache maxBreadth: (self cache maxBreadth max: measuredBreadth).

		"for convenience store a breadth which is to update weighted and alternative max breadth"
		matchingBreadth := childMatchBreadth ifTrue: [ (self orientation marginBreadth: child) ] ifFalse: [ measuredBreadth ].
		(self orientation lengthProperties: child) resizer isMatchParent
			ifTrue: [ self cache matchingMaxBreadth: (self cache matchingMaxBreadth max: matchingBreadth) ]
			ifFalse: [ self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: matchingBreadth) ] ]
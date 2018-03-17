private
validateLayoutParams: anElement
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
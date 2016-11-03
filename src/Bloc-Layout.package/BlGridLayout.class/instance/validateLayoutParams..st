private
validateLayoutParams: anElement
	| horizontal axis count major minor maxSizes |
	horizontal := self orientation isHorizontal.
	axis := self axis: horizontal.
	count := (axis definedCount ~= UNDEFINED)
		ifTrue: [ axis definedCount ]
		ifFalse: [ 0 ].

	major := 0.
	minor := 0.
	maxSizes := Array new: count withAll: 0.

	anElement managedChildren do: [ :child |
		| majorSpec majorRange majorWasDefined majorSpan minorSpec minorRange minorWasDefined minorSpan |
		majorSpec := horizontal
			ifTrue: [ child constraints vertical spec ]
			ifFalse: [ child constraints horizontal spec ].

		majorRange := majorSpec span.
		majorWasDefined := majorSpec startDefined.
		majorSpan := majorRange size - 1.
		majorWasDefined
			ifTrue: [ major := majorRange first - 1 ].
		
		minorSpec := horizontal
			ifTrue: [ child constraints horizontal spec ]
			ifFalse: [ child constraints vertical spec ].
		minorRange := minorSpec span.
		minorWasDefined := minorSpec startDefined.
		minorSpan := self clip: minorRange isDefined: minorWasDefined count: count.
		minorWasDefined
			ifTrue: [ minor := minorRange first - 1 ].

		count ~= 0 ifTrue: [
			(majorWasDefined and: [ minorWasDefined ] ) ifFalse: [ 
				[ self fits: maxSizes from: minor + 1 to: minor + minorSpan with: major ] whileFalse: [ 
					minorWasDefined
						ifTrue: [ major := major + 1 ]
						ifFalse: [ (minor + minorSpan <= count)
							ifTrue: [ minor := minor + 1 ]
							ifFalse: [ minor := 0. major := major + 1 ] ] ] ].
			self fill: maxSizes from: minor + 1 to: minor + minorSpan with: major + majorSpan ].
		
		horizontal
			ifTrue: [ self setGroup: child row: major + 1 span: majorSpan col: minor + 1 span: minorSpan ]
			ifFalse: [ self setGroup: child row: minor + 1 span: minorSpan col: major + 1 span: majorSpan ].

		minor := minor + minorSpan ]
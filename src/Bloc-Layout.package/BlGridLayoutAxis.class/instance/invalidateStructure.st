invalidate
invalidateStructure
	maxIndex := UNDEFINED.

	groupBounds := nil.
	forwardLinks := nil.
	backwardLinks := nil.

	leadingMargins := nil.
	trailingMargins := nil.
	arcs := nil.

	locations := nil.

	deltas := nil.
	hasWeightsValid := false.

	self invalidateValues.
	
	element ifNil: [ ^ self ].
	
	childConstraints := self element children accountedByLayout collect: [ :child |
		self horizontal
			ifTrue: [ child constraints grid horizontal ]
			ifFalse: [ child constraints grid vertical ] ].
		
	"totalMargins := self element managedChildren collect: [ :child |
			self layout measurer totalMarginOf: child isHorizontal: self horizontal ]."
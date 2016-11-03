accessing properties
effectProperty
	^ effect
		ifNil: [ effect := BlObjectProperty
				on: self
				named: #effect
				default: (BlNullEffect on: self) ]
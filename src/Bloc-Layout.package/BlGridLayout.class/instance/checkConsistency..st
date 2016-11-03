private
checkConsistency: anElement

	lastLayoutParamsHashCode
		ifNil: [
			self validateLayoutParams: anElement.
			lastLayoutParamsHashCode := self constraintsHashCode: anElement ]
		ifNotNil: [ 
			lastLayoutParamsHashCode ~= (self constraintsHashCode: anElement) ifTrue: [ 
				Warning signal: 'Layout constraints were modified between layout operations'.	
				self invalidateStructure.
				self checkConsistency: anElement ] ]
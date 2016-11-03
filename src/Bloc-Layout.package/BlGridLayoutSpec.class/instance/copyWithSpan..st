copying
copyWithSpan: newSpan
	^ self class new
		setAlignment: alignment
		span: newSpan
		startDefined: startDefined
		weight: weight
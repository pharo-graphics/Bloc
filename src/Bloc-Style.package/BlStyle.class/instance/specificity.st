accessing
specificity
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
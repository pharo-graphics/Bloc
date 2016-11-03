accessing properties
toProperty
	^ to ifNil: [ to := BlLinePointProperty on: self named: #to default: 1@1]
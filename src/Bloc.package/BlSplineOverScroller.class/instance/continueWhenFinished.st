scrolling
continueWhenFinished
	| aResult |
	
	aResult := currentStep onFinished: self.
		
	aResult
		ifFalse: [ ^ false ].
	
	self update.
	^ true
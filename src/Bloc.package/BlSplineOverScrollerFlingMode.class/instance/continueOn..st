updating
continueOn: aSplineOverScroller
	| aResult |
	
	aResult := aSplineOverScroller currentStep onFinished: aSplineOverScroller.
	aResult
		ifFalse: [ ^ false ].

	^ true
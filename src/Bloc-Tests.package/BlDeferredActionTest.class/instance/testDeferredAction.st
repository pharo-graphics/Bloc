tests
testDeferredAction
	| runFlag processflag |
	processflag := runFlag := false.
	BlUniverse reset.
	BlUniverse default
		start;
		defer: [ runFlag := true.
			processflag := BlUniverse default isUIProcess  ].
	(Delay forSeconds: 1) wait.
	BlUniverse reset.
	self assert: runFlag description:'the deferred action should be run'.
	self assert: processflag description:'the deferred action should be run within the UI Process'.
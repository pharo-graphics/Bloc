tests
testEmpty

	| insets |
	insets := BlInsets empty.

	self 
		assert: insets left 		equals: 0;
		assert: insets right 		equals: 0;
		assert: insets top 		equals: 0;
		assert: insets bottom 	equals: 0;
		assert: insets width 		equals: 0;
		assert: insets height 	equals: 0.
	
	
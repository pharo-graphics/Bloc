tests
assertInset: anInsets
	 
	self 
		assert: anInsets left 		equals: 2;
		assert: anInsets right 		equals: 4;
		assert: anInsets top 		equals: 1;
		assert: anInsets bottom 	equals: 3;
		assert: anInsets width 		equals: 6;
		assert: anInsets height 	equals: 4.
	
	
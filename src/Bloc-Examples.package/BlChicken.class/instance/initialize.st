initialization
initialize
	super initialize.
	

	self addChildren: { 
		BlChickenHead new
			constraintsDo: [ :c |
				c frame horizontal alignCenter.
				c horizontal exact: 75.
				c vertical exact: 75 ];
			yourself.
		BlChickenBody new
			constraintsDo: [ :c |
				c frame horizontal alignCenter.
				c frame vertical alignCenter.
				c horizontal exact: 250.
				c vertical exact: 200 ];
			yourself.
			
		BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c |
				c frame horizontal alignCenter.
				c frame vertical alignBottom.
				c horizontal fitContent.
				c vertical fitContent ];
			addChildren: { 
				BlChickenLeg new
					size: 50@100;
					margin: (BlInsets right: 5).
				BlChickenLeg new
					size: 50@100;
					margin: (BlInsets left: 5).
			};
			yourself
			
		
			
	}
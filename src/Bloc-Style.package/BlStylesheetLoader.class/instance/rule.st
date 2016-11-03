grammar
rule
	^ super rule
		==> [ :nodes | 
			BlStyleRule new
				selectors: nodes first;
				declarations: nodes third;
				yourself ]
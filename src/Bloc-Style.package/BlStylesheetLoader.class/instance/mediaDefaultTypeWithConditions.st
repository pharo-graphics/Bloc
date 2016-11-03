grammar media
mediaDefaultTypeWithConditions
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			BlStyleMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
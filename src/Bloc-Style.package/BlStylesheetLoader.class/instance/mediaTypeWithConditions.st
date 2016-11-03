grammar media
mediaTypeWithConditions
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			BlStyleMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
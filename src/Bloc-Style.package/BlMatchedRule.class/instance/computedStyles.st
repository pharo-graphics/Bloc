as yet unclassified
computedStyles
	^ self declarations
		collect: [ :d | 
			BlStyle new
				selector: self selector;
				declaration: d;
				conditions: self conditions;
				yourself ]
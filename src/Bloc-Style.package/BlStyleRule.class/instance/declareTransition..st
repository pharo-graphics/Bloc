as yet unclassified
declareTransition: anAssoc
	self transitions
		add:
			(BlStyleTransitionDeclaration new
				property: anAssoc key;
				valuesFromArray: anAssoc value;
				rule: self;
				yourself)
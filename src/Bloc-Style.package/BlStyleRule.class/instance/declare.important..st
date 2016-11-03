as yet unclassified
declare: anAssoc important: aBoolean
	self declarations
		add:
			(BlStylePropertyDeclaration new
				property: anAssoc key;
				value: anAssoc value asBlStyleValue;
				rule: self;
				important: aBoolean;
				yourself)
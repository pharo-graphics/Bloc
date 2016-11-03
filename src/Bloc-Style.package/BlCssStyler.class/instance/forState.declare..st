computing styles
forState: aSymbol declare: anAssoc
|aSelector|

aSelector := BlStyleLocalSelector target:self styleable.
aSymbol ifNotNil:[aSelector pseudoClasses add: (BlState fromSymbol:aSymbol)].
aSelector update.

	self styles
		add:
			(BlStyle new
				selector: aSelector;
				ordinal: (inlineOrdinalCnt := inlineOrdinalCnt +1);
				declaration:
					(BlStylePropertyDeclaration new
						property: anAssoc key;
						value: anAssoc value asBlStyleValue;
						rule: nil;
						yourself))
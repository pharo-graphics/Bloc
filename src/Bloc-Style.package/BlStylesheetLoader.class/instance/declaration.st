grammar declaration
declaration
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ BlStyleTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ BlStylePropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
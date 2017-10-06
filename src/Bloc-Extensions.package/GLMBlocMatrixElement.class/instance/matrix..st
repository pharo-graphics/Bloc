accessing
matrix: aMatrix
	| theCellElements |

	gridElement layoutDo: [ :l |
		l columnCount: aMatrix columnCount.
		l cellSpacing: 3 ].
	
	theCellElements := aMatrix collect: [ :aNumber |
		| textCell numberString |
		
		numberString := ((aNumber closeTo: aNumber integerPart)
			ifTrue: [ aNumber asInteger ]
			ifFalse: [ (aNumber round: 2) ]) printString.
		
		textCell := self newCellElement
			text: (self asCellText: numberString);
			constraintsDo: [ :c |
				c grid horizontal alignCenter ]
			
	] as: Array.

	gridElement addChildren: theCellElements
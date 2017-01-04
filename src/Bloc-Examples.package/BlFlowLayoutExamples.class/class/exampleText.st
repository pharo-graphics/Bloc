examples
exampleText
	<example>
	| aText aLineIterator  theWords aParent aSpace floatA |

	theWords := OrderedCollection new.

	aText := SpText fromString: (String loremIpsum: 10000).

	aLineIterator := aText rope iterator.

	[ aLineIterator hasNext ] whileTrue: [ 
		| aLine aWordIterator aBreak |
		aLine := aLineIterator nextLine.
		aWordIterator := aLine iterator.
		aBreak := true.
		[ aWordIterator hasNext ] whileTrue: [ 
			| aWord |
			aWord := aWordIterator nextWord.
			theWords add: (BlTextElement new
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent.
					c flow newLine: aBreak ];
				text: (SpText fromRope: aWord);
				yourself).
			aBreak := false ] ].

	floatA := BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 63.
			c vertical exact: 65.
			c margin: (BlInsets top: 3 right: 3 bottom: 0 left: 3) ];
		background: Color magenta.

	theWords add: floatA afterIndex: (theWords size / 3) asInteger.

	aParent := BlElement new
		layout: BlFlowLayout new horizontal;
		constraintsDo: [ :c |
			c horizontal exact: 560.
			c vertical fitContent ];
		position: 100 @ 50;
		background: Color white;
		addChildren: theWords;
		yourself.

	aSpace := BlSpace new.
	aSpace root addChild: aParent.
	BlElementSelection on: aParent.
	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show
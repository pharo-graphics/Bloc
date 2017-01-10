shape examples
exampleWithShadow
	| anElement |

	anElement := BlElement new
		size: 100@50;
		position: 200@150;
		border: (BlBorder color: Color black width: 2 radius: 8);
		background: Color red;
		effect: (BlDropShadowEffect color: Color black width: 20 offset: 5@5);
		scaleBy: 2;
		yourself.

	BlSpace new
		extent: 600 @ 450;
		rootDo: [ :aRootElement |
			aRootElement addChild: anElement.
			aRootElement addEventHandler:
				(BlEventHandler
					on: BlDblClickEvent
					do: [ :anEvent | BlElementSelection on: anEvent  target ]) ];
		title: 'Shape example';
		show
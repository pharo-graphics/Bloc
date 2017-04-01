shape examples
exampleWithShadow
	| aRectangle anEllipse |

	aRectangle := BlElement new
		size: 300@150;
		position: 50@150;
		border: (BlBorder paint: Color black width: 2);
		background: Color red;
		effect: (BlDropShadowEffect color: Color black width: 20 offset: 10@10);
		yourself.

	anEllipse := BlElement new
		size: 300@150;
		geometry: BlEllipse new;
		position: 500@150;
		border: (BlBorder paint: Color black width: 2);
		background: Color red;
		effect: (BlDropShadowEffect color: Color black width: 20 offset: 10@10);
		yourself.
		

	BlSpace new
		extent: 900 @ 450;
		rootDo: [ :aRootElement |
			aRootElement addChild: aRectangle.
			aRootElement addChild: anEllipse.
			aRootElement addEventHandler:
				(BlEventHandler
					on: BlDblClickEvent
					do: [ :anEvent | BlElementSelection on: anEvent  target ]) ];
		title: 'Shape example';
		show
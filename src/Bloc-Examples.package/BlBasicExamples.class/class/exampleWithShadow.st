shape examples
exampleWithShadow
	| space c1|
	
		c1 := BlElement new
		position: 200@200;
		border: (BlBorder color: Color black width: 2 radius: 8);
		background:Color red;
		effect: (BlDropShadowEffect color: Color gray width: 5 offset: 2@2).
		
	
	space := BlSpace new
		extent: 600 @ 450;
		rootDo:[:r| r addChild:c1];
		title: 'Shape example';
		show.
	
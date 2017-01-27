drawing
drawPathOnSpartaCanvas: aCanvas
	| anEye |
	super drawPathOnSpartaCanvas: aCanvas.
	
	anEye := aCanvas shape circleAt: 0@0 radius: self extent min / 8.0.
	
	aCanvas transform
		push;
		translateBy: (self width / 4.0) @ (self height / 3.0);
		apply.
	
	aCanvas fill
		paint: Color white;
		path: anEye;
		draw;
		paint: Color black;
		path: (aCanvas shape circleAt: (self extent min / 32.0)  @ 0  radius: self extent min / 16.0);
		draw.
		
	aCanvas stroke
		paint: Color brown;
		path: anEye;
		width: 1;
		draw.
		
	aCanvas transform
		translateBy: (self width / 2.0) @ 0;
		apply.
		
	aCanvas fill
		paint: Color white;
		path: anEye;
		draw;
		paint: Color black;
		path: (aCanvas shape circleAt: (self extent min / 32.0) negated @ 0  radius: self extent min / 16.0);
		draw.

	aCanvas stroke
		paint: Color brown;
		path: anEye;
		width: 1;
		draw.
	
	aCanvas transform
		translateBy: (self width / 4.0) negated @ (self height / 4.0);
		apply.

	aCanvas fill
		path: (aCanvas path
			relative;
			moveTo: self width / -16.0 @ 0;
			lineTo: self width / 16.0 @ (self height / 2.0);
			lineTo: self width / 16.0 @ (self height / -2.0);
			lineTo: self width / 16.0 negated @ 0;
			close;
			finish);
		paint: Color red;
		draw.
	
	aCanvas transform pop.
		
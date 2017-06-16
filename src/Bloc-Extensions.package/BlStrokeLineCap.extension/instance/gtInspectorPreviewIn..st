*Bloc-Extensions
gtInspectorPreviewIn: aComposite
	<gtInspectorPresentationOrder: 5>

	aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		when: [ self class ~= BlStrokeLineCap ];
		draw: [ :aCanvas | | path width |
			width :=  40.
			path := aCanvas path
				absolute;
				moveTo: aCanvas extent / (8.0 @ 2.0);
				lineTo: aCanvas extent / ((8.0 / 7.0) @ 2.0);
				finish.

			aCanvas stroke
				paint: Color veryVeryDarkGray lighter;
				path: path;
				width: width;
				in: [ :aStrokePainter | self applyOn: aStrokePainter ];
				draw.

			aCanvas stroke
				paint: (Color fromHexString: '00b0ff');
				path: path;
				width: 2;
				draw.

			aCanvas fill
				paint: (Color fromHexString: '00b0ff');
				path: (aCanvas shape circleAt: aCanvas extent / (8.0 @ 2.0) radius: 5);
				draw.
				
			aCanvas fill
				paint: (Color fromHexString: '00b0ff');
				path: (aCanvas shape circleAt: aCanvas extent / ((8.0 / 7.0) @ 2.0) radius: 5);
				draw ]
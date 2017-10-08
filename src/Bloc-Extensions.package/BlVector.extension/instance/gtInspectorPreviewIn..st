*Bloc-Extensions
gtInspectorPreviewIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	^ aComposite sparta
		title: 'Preview';
		extent: 1024@1024;
		draw: [ :aCanvas |
			| aVector scaleFactor aFont aText aMetrics aTextPainter |
			
			scaleFactor := 200.0 / self length.

			aText := (self length printShowingDecimalPlaces: 3).

			aFont := aCanvas font
				size: 15 / scaleFactor;
				build.

			aTextPainter := aCanvas text
				font: aFont;
				string: aText.
			
			aMetrics := aTextPainter measure.
			aTextPainter baseline: (self length - aMetrics textMetrics bounds width)/ 2 @ (4 / scaleFactor) negated.

			aVector := aCanvas path
				relative;
				moveTo: 0@0;
				lineTo: self length @ 0;
				moveTo: (2 / scaleFactor) @ 0;
				moveTo: ((10 / scaleFactor) @ (6 / scaleFactor)) negated;
				lineTo: ((10 / scaleFactor) @ (6 / scaleFactor)) ;
				lineTo: (10 / scaleFactor) negated @ (6 / scaleFactor);
				build.

			aCanvas fill
				paint: Color white;
				path: aCanvas bounds;
				draw.
			
			aCanvas transform push.

			aCanvas transform
				translateBy: (((self x sign @ self y sign) min: 0@0) * 200 negated) + (100@50);
				apply.
				
			aCanvas transform push.
			
			aCanvas transform
				scaleBy: scaleFactor asPoint;
				rotateByRadians: ((self x @ self y) angleWith: 1 @ 0 ) negated;
				apply.	
			
			aCanvas fill
				path: (aCanvas shape ellipse: ((5@5) / scaleFactor negated extent: (10@10) / scaleFactor));
				paint: (Color black alpha: 0.3);
				draw.
			aCanvas fill
				path: (aCanvas shape ellipse: ((self length  @ 0) + ((2@5) negated / scaleFactor) extent: (10@10) / scaleFactor));
				paint: (Color black alpha: 0.3);
				draw.
			
			aCanvas stroke
				paint: Color black;
				path: aVector;
				width: 2 / scaleFactor;
				draw.
			aTextPainter draw.
			
			aCanvas transform pop.

			aFont := aCanvas font
				size: 15;
				build.
			
			"from"
			aTextPainter := aCanvas text
				font: aFont;
				string: ('({1},{2})' format: { 0 . 0 }).
			aMetrics := aTextPainter measure.
			aTextPainter
				baseline: (aMetrics textMetrics bounds width / 2 @ 10) negated;
				draw.
			
			"to"
			aTextPainter := aCanvas text
				font: aFont;
				string: ('({1},{2})' format: { self x . self y }).
			aMetrics := aTextPainter measure.
			aTextPainter
				baseline: (((self x sign @ self y sign)) * (self x @ self y) * scaleFactor) + (aMetrics textMetrics bounds width / 2 negated + 5 @ (aMetrics textMetrics bounds height + 10)) ;
				draw.


			aCanvas transform pop.
			
			];
		when: [ self hasComponentZ not and: [ self length isZero not ] ]
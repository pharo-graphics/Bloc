Extension { #name : #BlStrokeLineCap }

{ #category : #'*Bloc-Extensions' }
BlStrokeLineCap >> gtInspectorOtherTypesIn: aComposite [
	<gtInspectorPresentationOrder: 6>

	^ (self class gtInspectorTypesIn: aComposite)
		title: [ 'Other types' translated ];
		when: [ self class ~= BlStrokeLineCap ]
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineCap >> gtInspectorPreviewIn: aComposite [
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
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineCap >> gtInspectorTypesIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ self class gtInspectorTypesIn: aComposite
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineCap class >> gtInspectorTypesIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	^ aComposite fastList
		title: [ 'Types' translated ];
		when: [ self == BlStrokeLineCap ];
		display: [ { self butt. self round. self square } ];
		format: [ :each | each class capName ]
]

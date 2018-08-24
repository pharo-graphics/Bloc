Extension { #name : #BlStrokeLineJoin }

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtInspectorOtherTypesIn: aComposite [
	<gtInspectorPresentationOrder: 6>
	
	^ (self class gtInspectorTypesIn: aComposite)
		title: [ 'Other types' translated ];
		when: [ self class ~= BlStrokeLineJoin ]
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		when: [ self class ~= BlStrokeLineJoin ];
		draw: [ :aCanvas | | path width |
			width :=  40.
			path := aCanvas path
				absolute;
				moveTo: width @ (aCanvas extent y / 5.0 * 4.0);
				lineTo: (aCanvas extent x / 2) @ (aCanvas extent y / 4.0);
				lineTo: (aCanvas extent x - width) @ (aCanvas extent y / 5.0 * 4.0);
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
				path: (aCanvas shape circleAt: (aCanvas extent x / 2) @ (aCanvas extent y / 4.0 + 1) radius: 5);
				draw ]
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtInspectorTypesIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ self class gtInspectorTypesIn: aComposite
]

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin class >> gtInspectorTypesIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	^ aComposite fastList
		title: [ 'Types' translated ];
		when: [ self == BlStrokeLineJoin ];
		display: [  { self bevel. self miter. self round } ];
		format: [ :each | each class joinName ]
]

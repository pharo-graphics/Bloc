Extension { #name : #BlStrokeLineJoin }

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtInspectorOtherTypesIn: aComposite [
	<gtInspectorPresentationOrder: 6>
	
	^ (self class gtInspectorTypesIn: aComposite)
		title: [ 'Other types' translated ];
		when: [ self class ~= BlStrokeLineJoin ]
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

{ #category : #'*Bloc-Extensions' }
BlStrokeLineJoin >> gtPreviewFor: aView [
	<gtView>
	
	self class = BlStrokeLineCap
		ifTrue: [ ^ aView empty ].
	
	^ aView sparta
		title: 'Preview' translated;
		priority: 11;
		matchParent;
		rendering: [ :aCanvas :anElement | | path width |
			width :=  40.
			path := aCanvas path
				absolute;
				moveTo: width @ (anElement extent y / 5.0 * 4.0);
				lineTo: (anElement extent x / 2) @ (anElement extent y / 4.0);
				lineTo: (anElement extent x - width) @ (anElement extent y / 5.0 * 4.0);
				finish.

			aCanvas stroke
				paint: (Color veryVeryDarkGray alpha: 0.8);
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
				path: (aCanvas shape circleAt: (anElement extent x / 2) @ (anElement extent y / 4.0 + 1) radius: 5);
				draw ]
]

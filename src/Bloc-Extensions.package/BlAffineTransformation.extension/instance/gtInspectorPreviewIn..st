*Bloc-Extensions
gtInspectorPreviewIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	^ aComposite sparta
		title: 'Preview';
		extent: 1024@1024;
		draw: [ :aCanvas |
			| aHouse |
			
			aHouse := aCanvas path
				relative;	
				"house"
				moveTo: 70@0;
				lineTo: 70@60;
				lineTo: 20 negated @ 0;
				lineTo: 0@115;
				lineTo: 100 negated @ 0;
				lineTo: 0@115 negated;
				lineTo: 100@0;
				moveTo: 100 negated @ 0;
				lineTo: 20 negated @ 0;
				lineTo: 70@60 negated;
				"window"
				moveTo: 35 negated @ 80;
				lineTo: 30@0;
				lineTo: 0@30;
				lineTo: 30 negated @ 0;
				lineTo: 0@30 negated;
				"door"
				moveTo: 40 @ 95;
				lineTo: 0 @ 50 negated;
				lineTo: 25 @ 0;
				lineTo: 0 @ 50;
				build.
			
			aCanvas fill
				paint: Color white;
				path: aCanvas bounds;
				draw.
			
			aCanvas transform push.
			
			aCanvas transform
				translateBy: 50@50;
				apply.
					
			aCanvas stroke
				paint: Color black;
				path: aHouse;
				width: 2;
				dashPattern: #(4 4);
				draw.
					
			aCanvas transform
				multiplyBy: self asMatrix;
				apply.
					
			aCanvas stroke
				paint: Color black;
				path: aHouse;
				width: 2;
				draw.
			
			aCanvas transform pop ];
		when: [ self is2D ]
*Bloc-Extensions
gtInspectorPreviewIn: aComposite
	<gtInspectorPresentationOrder: 5>

	^ aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		draw: [ :aCanvas | | anElement |
			anElement := BlElement new
				size: (aCanvas extent / 1.5);
				background: self;
				forceLayout.
			
			aCanvas transform during: [ :aTransform |
				aTransform translateBy: (aCanvas extent - (aCanvas extent / 1.5)) / 2.0.
				aTransform apply.
				aCanvas stroke	
					paint: Color black;
					width: 1;
					path: (0@0 extent: (aCanvas extent / 1.5));
					dashPattern: #(4 6);
					draw.
				self drawOnSpartaCanvas: aCanvas of: anElement ] ]
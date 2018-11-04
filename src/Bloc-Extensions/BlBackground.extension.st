Extension { #name : #BlBackground }

{ #category : #'*Bloc-Extensions' }
BlBackground >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	^ aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		draw: [ :aCanvas | | anElement |
			anElement := BlElement new
				size: (aCanvas extent / 1.5);
				background: self;
				forceLayout.
			aCanvas transform
				by: [ :aTransform | aTransform  translateBy: (aCanvas extent - (aCanvas extent / 1.5)) / 2.0 ]
				during: [
					aCanvas stroke	
						paint: Color black;
						width: 1;
						path: (0@0 extent: (aCanvas extent / 1.5));
						dashPattern: #(4 6);
						draw.
					self drawOnSpartaCanvas: aCanvas of: anElement ] ]
]

{ #category : #'*Bloc-Extensions' }
BlBackground >> gtViewBackgroundFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 50;
		stencil: [
			BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				padding: (BlInsets all: 50);
				addChild:(BlElement new
					size: 200@100;
					outskirts: (BlOutskirts inside);
					flag: 'There is a bug in drawing related to `compose` operator when border is present';
					"border: (BlBorder builder dashed; paint: Color gray; width: 1; build);"
					background: self) ]
]

Extension { #name : #BlBorder }

{ #category : #'*Bloc-Extensions' }
BlBorder >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		draw: [ :aCanvas | | anElement |
			anElement := BlElement new
				size: (aCanvas extent / 1.5);
				outskirts: BlOutskirts inside;
				border: self;
				forceLayout.
			
			aCanvas transform during: [ :aTransform |
				aTransform translateBy: (aCanvas extent - (aCanvas extent / 1.5)) / 2.0.
				aTransform apply.
				self drawOnSpartaCanvas: aCanvas of: anElement ] ]
]

{ #category : #'*Bloc-Extensions' }
BlBorder >> gtViewBorderFor: aView [
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
				addChild: (BlElement new
					size: 200@100;
					border: self) ]
]

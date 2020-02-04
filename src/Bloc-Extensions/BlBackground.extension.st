Extension { #name : #BlBackground }

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

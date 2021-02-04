Extension { #name : #BlBorder }

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

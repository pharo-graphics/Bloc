bounds
misalignedIcon
	<gtExample>
	| anIconElement aContainerElement aModel aLook |
	anIconElement := BlElement new
			size: 8@12;
	    	geometry: (BlPolygon vertices: { 0@3 . 8@7.5. 0@12 });
	    	background: Color green muchDarker.

	aContainerElement := BlElement new
			layout: BlLinearLayout horizontal alignCenter;
			constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ];
			background: (Color gray alpha: 0.3);
			padding: (BlInsets all: 3).
	aContainerElement transformDo: [ :t |
	    t origin: BlAffineTransformationTopLeftOrigin new.
	    t scaleBy: 10 ].
	aContainerElement margin: (BlInsets left: 5).
	aModel := BrButtonModel new.
	aModel icon: anIconElement.
	aModel label: 'Run'.
	aLook := BrIconLook new + BrLabelLook new.
	aContainerElement look: aLook.
	aContainerElement viewModel: aModel.
	^ aContainerElement
order
privateActionIcon
	"Return the icon for this action"
	| anIcon |
			
	anIcon := ((self iconNamed: #abstract) collectColors: [ :each | 
		(Color r: each red * 0.40  g: each green b: each blue * 0.5 alpha: each alpha) twiceLighter slightlyLighter ]).

	^ IconicButton new 
		target: method;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Overrides abstract method';
		borderWidth: 0
order
privateActionIcon
	"Return the icon for this action"
	| anIcon |
			
	anIcon := self iconNamed: #smallError.

	^ IconicButton new 
		target: method;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Method should be implemented';
		borderWidth: 0
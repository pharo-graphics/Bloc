order
privateActionIcon
	"Return the icon for this action"
	| anIcon |
	
	anIcon := self iconNamed: #abstract.

	^ IconicButton new 
			target: method;
			actionSelector: #browse;
			labelGraphic: anIcon;
			color: Color transparent;
			extent: self iconExtent;
			helpText: 'Browse the overriden trait';
			borderWidth: 0
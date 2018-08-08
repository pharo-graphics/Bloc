order
privateActionIcon
	"Return the icon for this action"
	| anIcon |
			
	anIcon := (self iconNamed: #announcement).

	^ IconicButton new 
		target: self;
		actionSelector: #browseEvents;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Browse event (scoped)';
		borderWidth: 0
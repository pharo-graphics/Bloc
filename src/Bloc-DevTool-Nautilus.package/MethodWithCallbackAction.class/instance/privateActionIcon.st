order
privateActionIcon
	"Return the icon for this action"
	| anIcon |
			
	anIcon := (self iconNamed: #class) collectColors: [ :each | 
		(each mixed: 0.5 with: Color magenta muchDarker) paler lighter lighter lighter  alpha: each alpha ].

	^ IconicButton new 
		target: self callbackOrNil;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Callback';
		borderWidth: 0
as yet unclassified
buttons

	^ BlStylesheetLoader
		parse:
			'
	BlButton { 
		background-color : green600;
		box-shadow: 0px 1px 5px rgba(grey500,0.5);
		border-radius : 3px;
		color : white;
		font-size: 12px;
	}
	BlButton:hovered{
		background-color : green500;
		box-shadow: 0px 1px 6px rgba(grey500,0.8);
	}
	BlButton:pressed{
		background-color : green400;
	}
	BlButton .ripple{
		transition : background-color 100ms linearColor;
		transition : radius 100ms linear;
		background-color : rgba(grey300, 0);
		radius : 5%;
	}
	
	
	'
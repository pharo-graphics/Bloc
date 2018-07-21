scripting
defaultActions
	self act: [ :aBlocPresentation | aBlocPresentation element zoomToActualSize ]
			icon: (Smalltalk ui icons iconNamed: #checkBoxPressed)
			entitled: 'Actual size';
		act: [ :aBlocPresentation | aBlocPresentation element zoomIn ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in';
		act: [ :aBlocPresentation | aBlocPresentation element zoomOut ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :aBlocPresentation | aBlocPresentation element zoomToFit ]
			icon: GLMUIThemeExtraIcons glamorousZoomToFit
			entitled: 'Zoom to fit';
		act: [ :aBlocPresentation :aGtMondrian | aGtMondrian inspect ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			entitled: 'Inspect'
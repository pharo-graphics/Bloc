as yet unclassified
gtInspectorActionClean
	<gtInspectorAction>
	
	^ GLMGenericAction new
		action: [ :aPresentation | loggedValues removeAll. aPresentation requestRefresh ];
		icon: GLMUIThemeExtraIcons glamorousTrash;
		title: 'Clean log'
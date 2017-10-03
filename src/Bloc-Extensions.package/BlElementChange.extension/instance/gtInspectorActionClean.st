*Bloc-Extensions
gtInspectorActionClean
	<gtInspectorAction>
	
	^ GLMGenericAction new
		action: [ :aPresentation | records removeAll. aPresentation requestRefresh ];
		icon: GLMUIThemeExtraIcons glamorousTrash;
		title: 'Clean log'
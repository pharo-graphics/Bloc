Extension { #name : #BlElementChange }

{ #category : #'*Bloc-Extensions' }
BlElementChange >> gtInspectorActionClean [
	<gtInspectorAction>
	
	^ GLMGenericAction new
		action: [ :aPresentation | records removeAll. aPresentation requestRefresh ];
		icon: GLMUIThemeExtraIcons glamorousTrash;
		title: 'Clean log'
]

{ #category : #'*Bloc-Extensions' }
BlElementChange >> gtInspectorChangesIn: composite [
	<gtInspectorPresentationOrder: 90>
		
	composite fastList 
		title: 'Changes' translated;
		display: [ self records asArray ]
]

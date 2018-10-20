Extension { #name : #BlMorphicWindow }

{ #category : #'*Bloc-Extensions' }
BlMorphicWindow >> gtActionExportAsPNG [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | spaceForm exportAsPNGSilently ];
		icon: GLMUIThemeExtraIcons glamorousSave;
		title: 'Export as PNG'
	 
]

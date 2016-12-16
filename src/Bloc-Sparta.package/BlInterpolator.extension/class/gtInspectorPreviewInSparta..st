*Bloc-Sparta
gtInspectorPreviewInSparta: composite
	<gtInspectorPresentationOrder: 0>  
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: 'Preview';
		display: [
			[ self asSpartaForm asMorph ]
			on: Error
			do:[ :e | IconicListItem
				text:' Error drawing Preview (', e description, ')'
				icon: (Smalltalk ui icons iconNamed: #smallWarningIcon) ] ];
		act: [ :pres | self asForm asMorph exportAsPNG ] entitled: 'Export as PNG'
*Bloc-Extensions-Inspector
gtInspectorMetricsIn: composite
	<gtInspectorPresentationOrder: 90>  
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: 'Metrics';
		display: [ 
			[ | metrics |
				self forceLayout.
				metrics := BlMetricsInspector new for: self.
				metrics asSpartaForm asMorph ]
				on: Error
				do:[ :error | IconicListItem text: error messageText icon: (Smalltalk ui icons iconNamed: #smallWarningIcon) ]
			
			
			];
		act: [ :pres | self exportAsPNG ] entitled: 'Export as PNG';
		act: [ :pres | self removeFromParent ] entitled: 'Delete'
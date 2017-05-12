*Bloc-Extensions-Inspector
gtInspectorPreviewIn: composite
	<gtInspectorPresentationOrder: 90>  
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: 'Preview';
		display: [
			[self asSpartaForm asMorph
				on: #mouseDown send: #value: to: [ :event | 
					morphPresentation selection: (self findMouseEventTargetAt: (self localPointToGlobal: event position)) ]] on:Error
			do:[IconicListItem text:'Error drawing Morph' icon: (Smalltalk ui icons iconNamed: #smallWarningIcon) ] ];
		act: [ :pres | self exportAsPNG ] entitled: 'Export as PNG';
		act: [ :pres | self removeFromParent ] entitled: 'Delete'
*Bloc-Extensions
gtInspectorPreviewIn: composite
	<gtInspectorPresentationOrder: 15>
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: [ 'Preview' translated ];
		display: [
			[self asSpartaForm asMorph
				on: #mouseDown send: #value: to: [ :event | 
					morphPresentation selection: (self findMouseEventTargetAt: (self localPointToGlobal: event position)) ]] on:Error
			do: [ :error |
				error freeze.
				(IconicListItem
					text: error messageText
					icon: #smallWarningIcon asIcon)
						on: #mouseDown send: #value: to: [ :event | error defaultAction ];
						yourself ] ];
		act: [ :pres | self removeFromParent ] entitled: 'Delete'
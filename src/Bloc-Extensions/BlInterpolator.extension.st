Extension { #name : 'BlInterpolator' }

{ #category : '*Bloc-Extensions' }
BlInterpolator class >> gtInspectorPreviewInSparta: composite [
	<gtInspectorPresentationOrder: 0>
	self default gtInspectorPreviewInSparta: composite
]

{ #category : '*Bloc-Extensions' }
BlInterpolator >> gtInspectorPreviewInSparta: composite [
	<gtInspectorPresentationOrder: 0>
	composite morph
		title: [ 'Preview' translated ];
		display: [ [ self asSpartaForm asMorph ]
				on: Error
				do: [ :e | IconicListItem text: ' Error drawing Preview (' , e description , ')' icon: #smallWarningIcon asIcon ] ];
		act: [ :pres | self asSpartaForm asMorph exportAsPNG ] entitled: 'Export as PNG' translated;
		when: [ self class ~~ BlInterpolator ]
]

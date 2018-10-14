Extension { #name : #BlTextParagraphLine }

{ #category : #'*Bloc-Extensions' }
BlTextParagraphLine >> gtInspectorSpansIn: composite [
	<gtInspectorPresentationOrder: 1>
		
	composite fastList 
		title: 'Spans' translated;
		display: [ self spans ]
]

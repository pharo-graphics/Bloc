Extension { #name : #BrTextParagraphLine }

{ #category : #'*Bloc-Extensions' }
BrTextParagraphLine >> gtInspectorSpansIn: composite [
	<gtInspectorPresentationOrder: 1>
		
	composite fastList 
		title: 'Spans' translated;
		display: [ self spans ]
]

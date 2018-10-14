Extension { #name : #BlText }

{ #category : #'*Bloc-Extensions' }
BlText >> gtInspectorTextIn: composite [  
	<gtInspectorPresentationOrder: -10>
	
	composite blocText 
		title: '_Text';
		display: [ self ]
]

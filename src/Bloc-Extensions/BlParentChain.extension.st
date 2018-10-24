Extension { #name : #BlParentChain }

{ #category : #'*Bloc-Extensions' }
BlParentChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]

Extension { #name : #BlFocusChain }

{ #category : #'*Bloc-Extensions' }
BlFocusChain >> gtInspectorChainIn: aComposite [
	<gtInspectorPresentationOrder: 5>
	
	^ aComposite blocMondrian
		title: 'Chain';
		painting: [ :view |
			view nodes
				shape: [ :each |
					BlElement new
						geometry: BlEllipse new;
						size: 20@20;
						border: (BlBorder paint: (each isFocused ifTrue: [ Color blue ] ifFalse: [ Color lightGray ]) width: 1) ];
				with: self asArray.
			view edges 
				fromCenterTop;
				toCenterBottom;
				passive; 
				connect: (self asArray select: #hasParent) from: #yourself to: #parent.
				
			view layout horizontalTree ]
]

{ #category : #'*Bloc-Extensions' }
BlFocusChain >> gtInspectorElementsIn: aComposite [
	<gtInspectorPresentationOrder: 10>
	
	^ aComposite fastList
		title: 'Elements';
		display: [ self asArray ]
]

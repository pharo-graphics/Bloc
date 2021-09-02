Extension { #name : 'BlRope' }

{ #category : '*Bloc-Extensions' }
BlRope >> gtInspectorChildrenIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite table
		title: 'Children';
		display: [ { self } ];
		children: [ :each | each children ];
		column: 'Class' evaluated: [ :each | each class name ];
		column: 'Description' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each ]
]

{ #category : '*Bloc-Extensions' }
BlRope >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 10>
	^ composite blocMondrian
		title: 'Tree';
		painting: [ :mondrian :x :presentation | self paintTreeWith: mondrian ]
]

{ #category : '*Bloc-Extensions' }
BlRope >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : '*Bloc-Extensions' }
BlRope >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : '*Bloc-Extensions' }
BlRope >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			(each isKindOf: BlCollectionRope)
				ifTrue: [
					BrLabel new
						aptitude: BrGlamorousLabelAptitude; 
						zIndex: 10;
						background: Color white;
						constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
						text: ((each from: 0 to: (100 min: each size))) ]
				ifFalse: [ 
					BlElement new 
						when: BlClickEvent do: [:event | event target phlow spawnObject: each ];
						zIndex: 10;
						geometry: BlEllipseGeometry new;
						border: (BlBorder paint: Color black width: 1);
						background: ((each isKindOf: BlAttributeRope) ifTrue: [ Color orange ] ifFalse: [ Color white ]);
						size: 10@10 ] ];
		with: (self withDeepCollect: #children).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout custom: (GtGraphTreeLayout new)
"view layout tree 
		nodeDistance: 20;
		levelDistance: 40"
]

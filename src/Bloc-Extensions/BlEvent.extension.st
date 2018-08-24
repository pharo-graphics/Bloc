Extension { #name : #BlEvent }

{ #category : #'*Bloc-Extensions' }
BlEvent >> gtInspectorCurrentTargetIn: composite [
	<gtInspectorPresentationOrder: 15>
	
	(self currentTarget isKindOf: BlElement)
		ifTrue: [ (self currentTarget gtInspectorPreviewIn: composite) title: 'Current target' ]
]

{ #category : #'*Bloc-Extensions' }
BlEvent >> gtInspectorTargetIn: composite [
	<gtInspectorPresentationOrder: 15>
	
	(self target isKindOf: BlElement)
		ifTrue: [ (self target gtInspectorPreviewIn: composite) title: 'Target' ]
]

{ #category : #'*Bloc-Extensions' }
BlEvent >> gtInspectorTraversedTargetsIn: aComposite [
	<gtInspectorPresentationOrder: 10>

	^ aComposite table
		title: 'Traversed';
		display: [ self traversedTargets ];
		icon: [ :each | each target asSpartaForm scaledToSize: 16@16 ];
		column: 'Phase'
			evaluated: [ :each | each type ]
			width: 100;
		column: 'Target'
			evaluated: [ :each | each target ];
		column: 'Dispatcher'
			evaluated: [ :each | each dispatcher ]
]

{ #category : #'*Bloc-Extensions' }
BlEvent >> gtInspectorTraversedTargetsOnTreeIn: composite [
	<gtInspectorPresentationOrder: 15>
	composite blocMondrian
		title: 'Tree';
		painting: [ :view | self traversedTargetsTreeWith: view ]
]

{ #category : #'*Bloc-Extensions' }
BlEvent >> traversedTargetsTreeWith: mondrian [
	| thePairs connectedTargets topMostTarget aCurrentTarget |
	thePairs := Array streamContents: [ :aStream | 
		self traversedTargets overlappingPairsDo: [ :from :to | aStream nextPut: from -> to ] ].

	aCurrentTarget := self traversedTargets first target.
	topMostTarget := (aCurrentTarget hasOwner)
		ifTrue: [ aCurrentTarget owner topMostParent ]
		ifFalse: [ aCurrentTarget ].
	connectedTargets := (topMostTarget isKindOf: BlElement)
		ifFalse: [ { topMostTarget } ] 
		ifTrue: [					
			| allNodes |
			allNodes := OrderedCollection with: topMostTarget.
			topMostTarget eventDispatcher handlersDo: [ :aHandler |
					aHandler hasOwner ifTrue: [ allNodes add: aHandler ] ].
			topMostTarget allChildrenBreadthFirstDo: [ :eachElement |
				allNodes add: eachElement.
				eachElement eventDispatcher handlersDo: [ :aHandler |
					aHandler hasOwner ifTrue: [ allNodes add: aHandler ] ] ].
			allNodes ]. 

	mondrian nodes
		shape: [ :aTarget |
			| text |
			text := aTarget gtDisplayString asRopedText.
			text attributes: {BrTextForegroundAttribute paint: Color lightGray}.
			BlTextElement new
				text: text;
				padding: (BlInsets all: 5) ];
		with: (connectedTargets).
	mondrian edges
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connect: (connectedTargets select: [ :each | each hasOwner ])
			from: [ :aTarget | aTarget owner ].

	mondrian edges
		shape: [ :x |
			| color |
			color := Color red.
			(x value isKindOf: BlEventTraversalBubblingStep) ifTrue: [ color := Color blue ].
			(x value isKindOf: BlEventTraversalTargetStep) ifTrue: [ color := Color green ].
			(x value isKindOf: BlEventTraversalForwardingStep) ifTrue: [ color := Color gray ].
			BlParabollaArcElement new 
				border: (BlBorder paint: (color alpha: 0.4) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (color alpha: 0.4); width: 2; build)) ];
		passive;
		connect: thePairs from: [ :x | x key target ]
		to: [ :x | x value target ].
	mondrian layout horizontalTree nodeDistance: 40
]

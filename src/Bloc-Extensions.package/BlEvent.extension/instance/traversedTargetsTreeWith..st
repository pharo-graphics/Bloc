*Bloc-Extensions
traversedTargetsTreeWith: mondrian
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
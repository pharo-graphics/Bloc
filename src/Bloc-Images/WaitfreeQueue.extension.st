Extension { #name : #WaitfreeQueue }

{ #category : #'*Bloc-Images' }
WaitfreeQueue >> gtGraphFor: aView [
	<gtView> 

	^aView mondrian 
		title: 'Graph' translated;
		painting: [ :mondrian | self paintGraphWith: mondrian ]
]

{ #category : #'*Bloc-Images' }
WaitfreeQueue >> itemCount [
	"Answer the number of items in the queue including dummies. 
	If queue is currently in the middle of extraction by other process, give a (very) approximate answer.
	
	This method having a non-deterministic results, because of nature of concurrent shared queue. 
	"
	
	| item count |

	item := dummy.

	count := 0.
	[ item := item next. item == dummy ifFalse: [ count := count + 1 ]. item isCircular ] whileFalse.

	count = 0 ifTrue: [
		"if queue is locked by other process, check the tail and give a (very) approximate answer."
		^ tail object == dummy ifTrue: [ 0 ] ifFalse: [ 1]
		].	

	^ count
]

{ #category : #'*Bloc-Images' }
WaitfreeQueue >> paintGraphWith: view [
	| itemArray |
	itemArray := self itemArray.
	view nodes 
		stencil: [ :node | 
				BlTextElement new 
						text: 'dummy' asRopedText glamorousRegularFont;
						padding: (BlInsets all: 5) ];
		with: dummy asOrderedCollection;
		stencil: [ :node | 
				BlTextElement new 
						text: node gtDisplayString asRopedText glamorousRegularFont;
						padding: (BlInsets all: 5) ];
		with: itemArray;
		stencil: [ :node | 
				BlTextElement new 
						text: ((node gtDisplayString asRopedText glamorousRegularFont foreground: Color blue));
						padding: (BlInsets all: 5) ];
		with: (itemArray collect: #object) asIdentitySet.
	view edges 
		fromCenterBottom;
		toCenterTop;
		stencil: [ :each | 
			BlParabollaArcElement new 
				border: (BlBorder paint: (Color black alpha: 0.4) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color black alpha: 0.4); width: 2; build))];
		connect: (itemArray, dummy asOrderedCollection) from: #yourself to: #next;
		stencil: [ :each | 
			BlParabollaArcElement new 
				border: (BlBorder paint: (Color blue alpha: 0.8) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color blue alpha: 0.8); width: 2; build))];
		connect: itemArray from: #yourself to: #object.
	view layout dominanceTree levelDistance: 30 "custom: GtGradNorthHierarchicalLayout new"
		"custom: GtGraphDominanceTreeLayout new".
]

{ #category : #'*Bloc-Images' }
WaitfreeQueue >> printOn: aStream [

	aStream 
		nextPutAll: self class name;
		nextPutAll: ' with ';
		print: self size;
		nextPutAll: ' from ';
		print: self itemCount;
	 	nextPutAll: ' items' .
]

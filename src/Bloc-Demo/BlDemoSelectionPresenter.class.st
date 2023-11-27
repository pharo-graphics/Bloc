Class {
	#name : #BlDemoSelectionPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'classes',
		'protocols',
		'methods',
		'code',
		'collector',
		'tree'
	],
	#category : #'Bloc-Demo-Spec2'
}

{ #category : #accessing }
BlDemoSelectionPresenter >> classes [ 
	^ classes
]

{ #category : #accessing }
BlDemoSelectionPresenter >> code [ 
	^ code
]

{ #category : #accessing }
BlDemoSelectionPresenter >> collector [ 
	^ collector 
]

{ #category : #initialization }
BlDemoSelectionPresenter >> connectClassesPresenter [

	classes whenSelectedItemChangedDo: [ :item |
		methods items: item children. methods selectIndex: 1]
]

{ #category : #initialization }
BlDemoSelectionPresenter >> connectMethodsPresenter [

	methods whenSelectedItemChangedDo: [ :item |
		item ifNotNil: [
			code beForMethod: item item.
			code text: item sourceCode ] ]
]

{ #category : #initialization }
BlDemoSelectionPresenter >> connectPresenters [

	"self connectClassesPresenter.
	self connectMethodsPresenter."
	self connectTreePresenter
]

{ #category : #initialization }
BlDemoSelectionPresenter >> connectTreePresenter [

	tree whenSelectedItemChangedDo: [ :item |
		item ifNotNil: [
			item class = BlDemoMethodNode ifTrue: [
				code beForMethod: item item.
				code text: item sourceCode.
				self executeCode  ] ] ]
]

{ #category : #layout }
BlDemoSelectionPresenter >> defaultLayout [

	| treeLayout |
	treeLayout := SpBoxLayout newTopToBottom
		              add: tree;
		              yourself.

	^ SpBoxLayout newTopToBottom
		  spacing: 5;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 5;
				   add: treeLayout;yourself);
		  add: code;
		  yourself
]

{ #category : #operations }
BlDemoSelectionPresenter >> executeCode [

	| res |
	res := tree selectedItem execute.
	self owner drawOnCanvas: res
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeClassesPresenter [

	classes := self newList.
	classes
		items: self collector classes;
		display: [ :node | node name ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		sortingBlock: [ :a :b | a name < b name ]
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeCodePresenter [

	code := self newCode.
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeCollector [

	collector := BlDemoCollector new.
	collector collectPackages: self packagesToCollect
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeMethodsPresenter [

	methods := self newList.
	methods
		display: [ :method | method selector ];
		sortingBlock: [ :a :b | a selector < b selector ];
		whenSelectedDo: [ :i | self executeCode ]
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializePathArray [

	| firstPackage firstClass firstItem |
	firstPackage := tree roots first.
	firstClass := firstPackage children first.
	firstItem := firstClass children first.
	^ {
		             firstPackage.
		             firstClass.
		             firstItem }.
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializePresenters [

	self initializeCollector.
	self initializeTreePresenter.
	"self initializeClassesPresenter.
	self initializeMethodsPresenter."
	self initializeCodePresenter
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeTreePresenter [

	| pathArray |
	tree := SpTreePresenter new
		        roots: self collector packages;
		        children: [ :aPackageNode | aPackageNode children ];
		        displayIcon: [ :aNode | self iconNamed: aNode icon ];
		        display: [ :aPackageNode | aPackageNode name ];
		        expandRoots.
	pathArray := self initializePathArray.
	tree selectPathByItems: pathArray scrollToSelection: true
]

{ #category : #accessing }
BlDemoSelectionPresenter >> methods [ 
	^ methods
]

{ #category : #accessing }
BlDemoSelectionPresenter >> packagesToCollect [

	^ RPackageOrganizer default packages select: [ :each |
		       each name includesSubstring: 'Bloc' ].
	 
]

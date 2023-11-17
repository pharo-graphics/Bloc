Class {
	#name : #BlDemoSelectionPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'classes',
		'protocols',
		'methods',
		'code',
		'collector'
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
			code text: item item sourceCode ]]
	
]

{ #category : #initialization }
BlDemoSelectionPresenter >> connectPresenters [

	self connectClassesPresenter.
	self connectMethodsPresenter
]

{ #category : #layout }
BlDemoSelectionPresenter >> defaultLayout [

	| classesLayout methodsLayout |
	classesLayout := SpBoxLayout newTopToBottom
		                 add: 'Classes' expand: false;
		                 add: classes;
		                 yourself.

	methodsLayout := SpBoxLayout newTopToBottom
		                 add: 'Methods' expand: false;
		                 add: methods;
		                 yourself.

	^ SpBoxLayout newTopToBottom
		  spacing: 5;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 5;
				   add: classesLayout;
				   add: methodsLayout;
				   yourself);
		  add: code;
		  yourself
]

{ #category : #'as yet unclassified' }
BlDemoSelectionPresenter >> executeCode [

	| class method res |
	class := self classes selectedItem.
	method := self methods selectedItem.
	res := class item new perform: method item selector asSymbol.
	self owner drawOnCanva: res
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializeClassesPresenter [

	classes := self newList.
	classes
		items: self collector classes;
		display: [ :node | node item name ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		sortingBlock: [ :a :b | a item name < b item name ]
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
		display: [ :method | method item selector ];
		sortingBlock: [ :a :b | a item selector < b item selector ];
		whenSelectedDo: [ :i | self executeCode ]
]

{ #category : #initialization }
BlDemoSelectionPresenter >> initializePresenters [

	self initializeCollector.
	self initializeClassesPresenter.
	self initializeMethodsPresenter.
	self initializeCodePresenter
]

{ #category : #accessing }
BlDemoSelectionPresenter >> methods [ 
	^ methods
]

{ #category : #'as yet unclassified' }
BlDemoSelectionPresenter >> packagesToCollect [

	^ RPackageOrganizer default packages select: [ :each |
		       each name includesSubstring: 'Bloc' ].
	 
]

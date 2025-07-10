Class {
	#name : #BlDemoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'canva',
		'errorMessage',
		'code',
		'collector',
		'tree'
	],
	#category : #'Bloc-Demo-Spec2'
}

{ #category : #running }
BlDemoPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Bloc demo browser')
		parent: #Bloc;
		order: 0.1;
		action: [ self open ];
		help: 'Open a demo browser of Bloc to display multiple example of Bloc usages.';
		iconName: #go
]

{ #category : #running }
BlDemoPresenter class >> open [

	<script>
	self new open
]

{ #category : #accessing }
BlDemoPresenter >> canva [ 
	^ canva 
]

{ #category : #accessing }
BlDemoPresenter >> canva: aCanva [
	canva := aCanva 
]

{ #category : #accessing }
BlDemoPresenter >> code [ 
	^ code
]

{ #category : #accessing }
BlDemoPresenter >> collector [ 
	^ collector
]

{ #category : #initialization }
BlDemoPresenter >> connectPresenters [

	tree whenSelectedItemChangedDo: [ :item |
		item ifNotNil: [
			item class = BlDemoMethodNode
				ifTrue: [
					code beForMethod: item item.
					code text: item sourceCode.
					self executeCode ] ] ]
]

{ #category : #layout }
BlDemoPresenter >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 300;
				   add: tree;
				   add: canva yourself);
		  add: code;
		  yourself
]

{ #category : #drawing }
BlDemoPresenter >> drawOnCanvas: anElement [

	| root |
	root := self canva space root.
	root removeChildren.
	root addChild: ((anElement isKindOf: BlElement)
		ifTrue: [ anElement ]
		ifFalse: [ self errorMessage ])
]

{ #category : #accessing }
BlDemoPresenter >> errorMessage [

	^ errorMessage ifNil: [
		  BlElement new
			  background: Color lightRed;
			  layout: BlFrameLayout new;
			  constraintsDo: [ :c |
				  c vertical matchParent.
				  c horizontal matchParent ];
			  addChild: (BlTextElement new
					   text:
						   'This method does not return any element for you to see'
							   asRopedText;
					   constraintsDo: [ :c |
						   c frame vertical alignCenter.
						   c frame horizontal alignCenter ]) ]
]

{ #category : #operations }
BlDemoPresenter >> executeCode [

	| res |
	res := tree selectedItem execute.
	self drawOnCanvas: res
]

{ #category : #TOREMOVE }
BlDemoPresenter >> initialExtent [

	| fontWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self class inputTextHeight.

	^ (90@24) * (fontWidth @ rowHeight)
	
]

{ #category : #initialization }
BlDemoPresenter >> initializeCanvaPresenter [ 
	
	canva := SpBlSpaceInMorphPresenter new
]

{ #category : #initialization }
BlDemoPresenter >> initializeCodePresenter [

	code := self newCode
]

{ #category : #initialization }
BlDemoPresenter >> initializeCollector [

	collector := BlDemoCollector new.
	collector collectPackages: self packagesToCollect
]

{ #category : #initialization }
BlDemoPresenter >> initializePathArray [

	| firstPackage firstClass firstItem |
	firstPackage := tree roots first.
	firstClass := firstPackage children first.
	firstItem := firstClass children first.
	^ {
		  firstPackage.
		  firstClass.
		  firstItem }
]

{ #category : #initialization }
BlDemoPresenter >> initializePresenters [

	self initializeCollector.
	self initializeCanvaPresenter.
	self initializeTreePresenter.
	self initializeCodePresenter
]

{ #category : #initialization }
BlDemoPresenter >> initializeTreePresenter [

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
BlDemoPresenter >> packagesToCollect [

	^ self class packageOrganizer packages select: [ :each |
		  each name includesSubstring: 'Bloc' ]
]

{ #category : #TOREMOVE }
BlDemoPresenter >> title [ 
	^ 'Bloc UI Framework Demo'
]

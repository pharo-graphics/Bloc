"
I'm a little tool to browse and render demo of bloc.
The demoes are identified using the pragma <demo>
"
Class {
	#name : #BlDemoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'errorMessage',
		'code',
		'collector',
		'tree',
		'canvas'
	],
	#category : #'Bloc-Demo-DemoPresenterSpec'
}

{ #category : #accessing }
BlDemoPresenter class >> defaultPreferredExtent [

	| fontWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self inputTextHeight.

	^ (90@24) * (fontWidth @ rowHeight)
]

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
BlDemoPresenter >> canvas [

	^ canvas
]

{ #category : #accessing }
BlDemoPresenter >> canvas: aCanvas [

	canvas := aCanvas
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
				   add: canvas;
					yourself);
		  add: code;
		  yourself
]

{ #category : #drawing }
BlDemoPresenter >> drawOnCanvas: anElement [

	canvas space root
		removeChildren;
		addChild: 
			((anElement isKindOf: BlElement)
				ifTrue: [ anElement ]
				ifFalse: [ self notABlElementErrorMessage ])
]

{ #category : #errors }
BlDemoPresenter >> errorMessage: aString [

	^ errorMessage ifNil: [
			  BlElement new
				  background: Color lightRed;
				  layout: BlFrameLayout new;
				  constraintsDo: [ :c |
						  c vertical matchParent.
						  c horizontal matchParent ];
				  addChild: (BlTextElement new
						   text: aString asRopedText;
						   constraintsDo: [ :c |
								   c frame vertical alignCenter.
								   c frame horizontal alignCenter ]);
				  yourself ]
]

{ #category : #operations }
BlDemoPresenter >> executeCode [

	| item  |
	item := tree selectedItem.
	[ self drawOnCanvas: item execute ] 
		on: Error 
		do: [ :ex |
			canvas space root
				removeChildren;
				addChild: (self errorMessage: 'Execution of ', item item printString, ' led to an error') ]
]

{ #category : #initialization }
BlDemoPresenter >> initializeCanvasPresenter [ 
	
	canvas := SpBlSpaceInMorphPresenter new
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

	^ { firstPackage. firstClass. firstItem }
]

{ #category : #initialization }
BlDemoPresenter >> initializePresenters [

	self initializeCollector.
	self initializeCanvasPresenter.
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
		        expandAll;
		        yourself.
	pathArray := self initializePathArray.
	tree selectPathByItems: pathArray scrollToSelection: true
]

{ #category : #errors }
BlDemoPresenter >> notABlElementErrorMessage [

	^ self errorMessage:
		  'This method does not return any element for you to see'
]

{ #category : #accessing }
BlDemoPresenter >> packagesToCollect [
	
	| suffixes |
	suffixes := #('Bloc' 'Album' 'Toplo').
	
	^ self class packageOrganizer packages select: [ :package |
		suffixes anySatisfy: [ :each | package name includesSubstring: each ]]
]

{ #category : #accessing }
BlDemoPresenter >> windowTitle [

	^ 'Bloc UI Framework Demo'
]

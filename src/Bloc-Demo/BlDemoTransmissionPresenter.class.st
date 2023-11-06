Class {
	#name : #BlDemoTransmissionPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'classes',
		'protocols',
		'methods',
		'code'
	],
	#category : #'Bloc-Demo-Spec2'
}

{ #category : #accessing }
BlDemoTransmissionPresenter >> classes [ 
	^ classes
]

{ #category : #accessing }
BlDemoTransmissionPresenter >> code [ 
	^ code
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> connectClassesPresenter [

	classes
		transmitTo: protocols
		transform: [ :aClass |
			aClass
				ifNotNil: [
					|demoProtocols|
					demoProtocols := aClass organization protocols
						select: [ :each | each name includesSubstring: 'demo' ].
					demoProtocols collect: [ :each | aClass -> each ] as: OrderedCollection ]
				ifNil: [ #(  ) ] ]
		postTransmission: [ :destination :origin |
		destination selectIndex: 1 ].

	classes transmitTo: code transform: [ :aClass |
		aClass ifNotNil: [ aClass definitionString ] ifNil: [ '' ] ]
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> connectMethodsPresenter [

	methods
		transmitTo: code  
		transform: [ :aMethod | aMethod ifNotNil: [ aMethod sourceCode ] ifNil: [ '' ] ].
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> connectPresenters [

	self connectClassesPresenter.
	self connectProtocolsPresenter.
	self connectMethodsPresenter
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> connectProtocolsPresenter [

	protocols
		transmitTo: methods
		transform: [ :aPair | 
			aPair
				ifNotNil: [ 
					aPair value methodSelectors
						collect: [ :each | aPair key >> each ]
						as: OrderedCollection ]
				ifNil: [ #(  ) ] ].
			
	protocols
		transmitTo: code
		transform: [ :aPair | aPair ifNotNil: [ aPair key sourceCodeTemplate ] ifNil: [ '' ] ]
]

{ #category : #layout }
BlDemoTransmissionPresenter >> defaultLayout [

	|  classesLayout protocolsLayout methodsLayout |
	
	classesLayout := SpBoxLayout newTopToBottom
		add: 'Classes' expand: false;
		add: classes;
		yourself.
		
	protocolsLayout := SpBoxLayout newTopToBottom
		add: 'Protocols' expand: false;
		add: protocols;
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
			add: protocolsLayout;
			add: methodsLayout;
			yourself);	
		add: code;
		yourself
]

{ #category : #'as yet unclassified' }
BlDemoTransmissionPresenter >> executeCode [

	| class method res |
	class := self classes selectedItem.
	method := self methods selectedItem.
	res := class new perform: method selector asSymbol.
	self owner drawOnCanva: res
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> initializeClassesPresenter [

	classes := self newList.
	classes
		items: self itemsClasses;
		display: [ :class | class name ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		sortingBlock: [ :a :b | a name < b name ]
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> initializeCodePresenter [

	code := self newCode.
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> initializeMethodsPresenter [

	methods := self newList.
	methods
		display: [ :method | method selector ];
		sortingBlock: [ :a :b | a selector < b selector ];
		whenSelectedDo: [ :i | self executeCode ]
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> initializePresenters [ 
	self initializeClassesPresenter.
	self initializeProtocolsPresenter.
	self initializeMethodsPresenter.
	self initializeCodePresenter 
]

{ #category : #initialization }
BlDemoTransmissionPresenter >> initializeProtocolsPresenter [

	protocols := self newList.
	protocols
		display: [ :aPair | aPair value name ];
		sortingBlock: [ :a :b | a value name < b value name ]
]

{ #category : #'as yet unclassified' }
BlDemoTransmissionPresenter >> itemsClasses [

^ BlExampleTest allSubclasses select: [ :c | c name includesSubstring: 'Demo' ]
]

{ #category : #accessing }
BlDemoTransmissionPresenter >> methods [ 
	^ methods
]

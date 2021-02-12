Class {
	#name : #BlClickEventExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChild [
	<gtExample>
	| aScripter |
	aScripter := self twoElementsInScripter.
	
	aScripter substeps: 'Click in hidden child' do: [ :aStep |
		
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.
		
		aStep click onChildAt: 1.
		
		aStep check 
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleClippedGrandchild [
	<gtExample>
	| aScripter |
	aScripter := self threeElementsWithTrueChildClippingInScripter.
	
	aScripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.
		
		aStep click 
			onChildAt: 1;
			onChildAt: 1.
		
		aStep check 
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleGrandchild [
	<gtExample>
	| aScripter |
	aScripter := self threeElementsInScripter.
	
	aScripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.
		
		aStep click 
			onChildAt: 1;
			onChildAt: 1.
		
		aStep check 
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInHiddenChildAndVisibleUnclippedGrandchild [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self threeElementsWithFalseChildClippingInScripter.
	
	aScripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.
		
		aStep click 
			onChildAt: 1;
			onChildAt: 1.
		
		aStep check 
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInParentWithGoneChild [
	<gtExample>
	| aScripter |
	aScripter := self twoElementsInScripter.
	
	aScripter substeps: 'Click in gone child' do: [ :aStep |
		
		aStep do
			label: 'Set child with gone visibility';
			block: [ :aChild | aChild visibility: BlVisibility gone ];
			onChildAt: 1.
		
		aStep click.
		
		aStep check 
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - events' }
BlClickEventExamples >> clickInVisibleChild [
	<gtExample>
	| aScripter |
	aScripter := self twoElementsInScripter.
	
	aScripter substeps: 'Click in visible child' do: [ :aStep |
		aStep click onChildAt: 1.
		
		aStep check 
			label: 'Check the click was consumed by child';
			do: [
				| aClickCollection |
				aClickCollection := aScripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #child. ] 
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - elements' }
BlClickEventExamples >> element [
	<gtExample>
	^ BlElement new
		layout: BlLinearLayout vertical;
		border: (BlBorder paint: Color gray width: 1);
		background: Color purple muchLighter;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElements [
	<gtExample>
	^ self element
		addChild: (self element
			addChild: self element as: #grandchild;
			background: Color red muchLighter) 
		as: #child;
		background: Color green muchLighter;
		id: #parent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsInScripter [
	<gtExample>
	^ self scripterWithElement: [ :aTarget :aScripter | 
		| anElement aChild anEventCollection |
		anElement := self threeElements. 
		anEventCollection := aScripter userData 
			at: #clicks 
			ifAbsentPut: [ OrderedCollection new ].
		anElement when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #parent.
			anEvent consumed: true  ].
		aChild := anElement childAt: 1.
		aChild when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #child.
			anEvent consumed: true ].
		(aChild childAt: 1) when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #grandchild.
			anEvent consumed: true ].
		anElement
	]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElementsWithFalseChildClipping [
	<gtExample>
	| aParent aChild aGrandchild |
	aParent := self element
		background: Color green muchLighter;
		id: #parent;
		layout: BlFrameLayout new;
		size: 100@100.
	
	aChild := self element
		size: 30@30;
		id: #child;
		clipChildren: false;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	
	aGrandchild := self element
		size: 20@20;
		background: Color red muchLighter;
		id: #grandchild;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRightAt: 1.1.
			c ignored vertical alignTopAt: 1.1 ].
	
	aParent addChild: aChild.
	aChild addChild: aGrandchild.
	
	^ aParent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsWithFalseChildClippingInScripter [
	<gtExample>
	^ self scripterWithElement: [ :aTarget :aScripter | 
		| anElement aChild anEventCollection |
		anElement := self threeElementsWithFalseChildClipping. 
		anEventCollection := aScripter userData 
			at: #clicks 
			ifAbsentPut: [ OrderedCollection new ].
		anElement when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #parent.
			anEvent consumed: true  ].
		aChild := anElement childAt: 1.
		aChild when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #child.
			anEvent consumed: true ].
		(aChild childAt: 1) when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #grandchild.
			anEvent consumed: true ].
		anElement
	]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> threeElementsWithTrueChildClipping [
	<gtExample>
	| aParent aChild |
	aParent := self threeElementsWithFalseChildClipping.
	
	aChild := aParent childAt: 1.
	aChild clipChildren: true.
	
	^ aParent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> threeElementsWithTrueChildClippingInScripter [
	<gtExample>
	^ self scripterWithElement: [ :aTarget :aScripter | 
		| anElement aChild anEventCollection |
		anElement := self threeElementsWithTrueChildClipping. 
		anEventCollection := aScripter userData 
			at: #clicks 
			ifAbsentPut: [ OrderedCollection new ].
		anElement when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #parent.
			anEvent consumed: true  ].
		aChild := anElement childAt: 1.
		aChild when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #child.
			anEvent consumed: true ].
		(aChild childAt: 1) when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #grandchild.
			anEvent consumed: true ].
		anElement
	]
]

{ #category : #'examples - elements' }
BlClickEventExamples >> twoElements [
	<gtExample>
	^ self element
		addChild: self element as: #child;
		background: Color green muchLighter;
		id: #parent
]

{ #category : #'examples - elements in scripter' }
BlClickEventExamples >> twoElementsInScripter [
	<gtExample>
	^ self scripterWithElement: [ :aTarget :aScripter | 
		| anElement anEventCollection |
		anElement := self twoElements. 
		anEventCollection := aScripter userData 
			at: #clicks 
			ifAbsentPut: [ OrderedCollection new ].
		anElement when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #parent.
			anEvent consumed: true  ].
		(anElement childAt: 1) when: BlClickEvent do: [ :anEvent | 
			anEventCollection add: #child.
			anEvent consumed: true ].
		anElement
	]
]

Class {
	#name : #BlClickEventTest,
	#superclass : #TestCase,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #running }
BlClickEventTest >> setUp [

	super setUp.
	scripter := BlDevScripter new
]

{ #category : #running }
BlClickEventTest >> tearDown [

	scripter close.
	super tearDown
]

{ #category : #'running - elements' }
BlClickEventTest >> element [

	^ BlElement new
		  layout: BlLinearLayout vertical;
		  border: (BlBorder paint: Color gray width: 1);
		  background: Color purple muchLighter;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		yourself
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChild [

	self twoElementsInScripter.

	scripter substeps: 'Click in hidden child' do: [ :aStep |
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.

		aStep testClick onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChildAndVisibleClippedGrandchild [

	self threeElementsWithTrueChildClippingInScripter.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.

		aStep testClick
			onChildAt: 1;
			onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChildAndVisibleGrandchild [

	self threeElementsInScripter.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.

		aStep testClick
			onChildAt: 1;
			onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChildAndVisibleUnclippedGrandchild [

	self threeElementsWithFalseChildClippingInScripter.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.

		aStep testClick
			onChildAt: 1;
			onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInParentWithGoneChild [

	self twoElementsInScripter.

	scripter substeps: 'Click in gone child' do: [ :aStep |
		aStep do
			label: 'Set child with gone visibility';
			block: [ :aChild | aChild visibility: BlVisibility gone ];
			onChildAt: 1.

		aStep testClick.

		aStep check
			label: 'Check the click was consumed by parent';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInVisibleChild [

	self twoElementsInScripter.

	scripter substeps: 'Click in visible child' do: [ :aStep |
		aStep testClick onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by child';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #child ] ].

	scripter syncContinue
]

{ #category : #'running - elements' }
BlClickEventTest >> threeElements [

	^ self element
		  addChild: (self element
				   addChild: self element as: #grandchild;
				   background: Color red muchLighter)
		  as: #child;
		  background: Color green muchLighter;
		  id: #parent;
		  yourself
]

{ #category : #'running - elements in scripter' }
BlClickEventTest >> threeElementsInScripter [

	| anElement aChild anEventCollection |
	anElement := self threeElements.
	anEventCollection := scripter userData
		                     at: #clicks
		                     ifAbsentPut: [ OrderedCollection new ].
	anElement addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #parent.
				 anEvent consume ]).
	aChild := anElement childAt: 1.
	aChild addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #child.
				 anEvent consume ]).
	(aChild childAt: 1) addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #grandchild.
				 anEvent consume ]).
	scripter element: anElement.
	scripter syncContinue
]

{ #category : #'running - elements' }
BlClickEventTest >> threeElementsWithFalseChildClipping [

	| aParent aChild aGrandchild |
	aParent := self element
		           background: Color green muchLighter;
		           id: #parent;
		           layout: BlFrameLayout new;
		           extent: 100 @ 100;
		           yourself.

	aChild := self element
		          extent: 30 @ 30;
		          id: #child;
		          clipChildren: false;
		          constraintsDo: [ :c |
			          c frame horizontal alignCenter.
			          c frame vertical alignCenter ];
		          yourself.

	aGrandchild := self element
		               extent: 20 @ 20;
		               background: Color red muchLighter;
		               id: #grandchild;
		               constraintsDo: [ :c |
			               c ignoreByLayout.
			               c ignored horizontal alignRightAt: 1.1.
			               c ignored vertical alignTopAt: 1.1 ];
		               yourself.

	aParent addChild: aChild.
	aChild addChild: aGrandchild.

	^ aParent
]

{ #category : #'running - elements in scripter' }
BlClickEventTest >> threeElementsWithFalseChildClippingInScripter [

	| anElement aChild anEventCollection |
	anElement := self threeElementsWithFalseChildClipping.
	anEventCollection := scripter userData
		                     at: #clicks
		                     ifAbsentPut: [ OrderedCollection new ].
	anElement addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #parent.
				 anEvent consume ]).
	aChild := anElement childAt: 1.
	aChild addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #child.
				 anEvent consume ]).
	(aChild childAt: 1) addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #grandchild.
				 anEvent consume ]).
	scripter element: anElement.
	scripter syncContinue
]

{ #category : #'running - elements' }
BlClickEventTest >> threeElementsWithTrueChildClipping [

	| aParent aChild |
	aParent := self threeElementsWithFalseChildClipping.

	aChild := aParent childAt: 1.
	aChild clipChildren: true.

	^ aParent
]

{ #category : #'running - elements in scripter' }
BlClickEventTest >> threeElementsWithTrueChildClippingInScripter [

	| anElement aChild anEventCollection |
	anElement := self threeElementsWithTrueChildClipping.
	anEventCollection := scripter userData
		                     at: #clicks
		                     ifAbsentPut: [ OrderedCollection new ].
	anElement addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #parent.
				 anEvent consume ]).
	aChild := anElement childAt: 1.
	aChild addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #child.
				 anEvent consume ]).
	(aChild childAt: 1) addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #grandchild.
				 anEvent consume ]).
	scripter element: anElement.
	scripter syncContinue
]

{ #category : #'running - elements' }
BlClickEventTest >> twoElements [

	^ self element
		  addChild: self element as: #child;
		  background: Color green muchLighter;
		  id: #parent;
		  yourself
]

{ #category : #'running - elements in scripter' }
BlClickEventTest >> twoElementsInScripter [

	| anElement anEventCollection |
	anElement := self twoElements.
	anEventCollection := scripter userData
		                     at: #clicks
		                     ifAbsentPut: [ OrderedCollection new ].
	anElement addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #parent.
				 anEvent consume ]).
	(anElement childAt: 1) addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEventCollection add: #child.
				 anEvent consume ]).
	scripter element: anElement.
	scripter syncContinue
]

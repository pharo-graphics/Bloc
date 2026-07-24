Class {
	#name : #BlClickEventTest,
	#superclass : #TestCase,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #'running - elements' }
BlClickEventTest >> newElement [

	^ BlElement new
		  layout: BlLinearLayout vertical;
		  border: (BlBorder paint: Color gray width: 1);
		  background: Color purple muchLighter;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		yourself
]

{ #category : #'running - elements' }
BlClickEventTest >> newThreeElements [

	^ self newElement
		  addChild: (self newElement
				   addChild: self newElement as: #grandchild;
				   background: Color red muchLighter)
		  as: #child;
		  background: Color green muchLighter;
		  id: #parent;
		  yourself
]

{ #category : #'running - elements' }
BlClickEventTest >> newThreeElementsWithFalseChildClipping [

	| aParent aChild aGrandchild |
	aParent := self newElement
		           background: Color green muchLighter;
		           id: #parent;
		           layout: BlFrameLayout new;
		           extent: 100 @ 100;
		           yourself.

	aChild := self newElement
		          extent: 30 @ 30;
		          id: #child;
		          clipChildren: false;
		          constraintsDo: [ :c |
			          c frame horizontal alignCenter.
			          c frame vertical alignCenter ];
		          yourself.

	aGrandchild := self newElement
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

{ #category : #'running - elements' }
BlClickEventTest >> newThreeElementsWithTrueChildClipping [

	| aParent aChild |
	aParent := self newThreeElementsWithFalseChildClipping.

	aChild := aParent childAt: 1.
	aChild clipChildren: true.

	^ aParent
]

{ #category : #'running - elements' }
BlClickEventTest >> newTwoElements [

	^ self newElement
		  addChild: self newElement as: #child;
		  background: Color green muchLighter;
		  id: #parent;
		  yourself
]

{ #category : #'running - elements in scripter' }
BlClickEventTest >> scriptThreeElements [

	| anElement aChild anEventCollection |
	anElement := self newThreeElements.
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

{ #category : #'running - elements in scripter' }
BlClickEventTest >> scriptThreeElementsWithFalseChildClipping [

	| anElement aChild anEventCollection |
	anElement := self newThreeElementsWithFalseChildClipping.
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

{ #category : #'running - elements in scripter' }
BlClickEventTest >> scriptThreeElementsWithTrueChildClipping [

	| anElement aChild anEventCollection |
	anElement := self newThreeElementsWithTrueChildClipping.
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

{ #category : #'running - elements in scripter' }
BlClickEventTest >> scriptTwoElements [

	| anElement anEventCollection |
	anElement := self newTwoElements.
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

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChild [

	self scriptTwoElements.

	scripter substeps: 'Click in hidden child' do: [ :aStep |
		aStep do
			label: 'Set child with hidden visibility';
			block: [ :aChild | aChild visibility: BlVisibility hidden ];
			onChildAt: 1.

		aStep click onChildAt: 1.

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

	self scriptThreeElementsWithTrueChildClipping.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
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
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChildAndVisibleGrandchild [

	self scriptThreeElements.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
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
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInHiddenChildAndVisibleUnclippedGrandchild [

	self scriptThreeElementsWithFalseChildClipping.

	scripter substeps: 'Click in hidden grandchild' do: [ :aStep |
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
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #parent ] ].

	scripter syncContinue
]

{ #category : #tests }
BlClickEventTest >> testClickInParentWithGoneChild [

	self scriptTwoElements.

	scripter substeps: 'Click in gone child' do: [ :aStep |
		aStep do
			label: 'Set child with gone visibility';
			block: [ :aChild | aChild visibility: BlVisibility gone ];
			onChildAt: 1.

		aStep click.

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

	self scriptTwoElements.

	scripter substeps: 'Click in visible child' do: [ :aStep |
		aStep click onChildAt: 1.

		aStep check
			label: 'Check the click was consumed by child';
			do: [
				| aClickCollection |
				aClickCollection := scripter userData at: #clicks.
				self assert: aClickCollection size equals: 1.
				self assert: aClickCollection first equals: #child ] ].

	scripter syncContinue
]

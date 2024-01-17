Class {
	#name : 'BlFocusProcessorExamples',
	#superclass : 'BlEventProcessorExamplesTest',
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'private - instance creation' }
BlFocusProcessorExamples >> elementWithFocusHandler [

	<sampleInstance>
	| aTextStyler hasFocus isFocused aTextBuilder aLabel |
	hasFocus := isFocused := false.
	aTextStyler := [ :aString | aString asRopedText light fontSize: 9 ].

	aTextBuilder := [
	                | aText |
	                aText := '' asRopedText.
	                aText append: (isFocused
			                 ifTrue: [
			                 (aTextStyler value: 'is focused') foreground:
				                 Color blue ]
			                 ifFalse: [ aTextStyler value: 'not focused' ]).
	                aText append: (aTextStyler value: ' / ').
	                aText append: (hasFocus
			                 ifTrue: [
			                 (aTextStyler value: 'has focus') foreground:
				                 Color blue ]
			                 ifFalse: [ aTextStyler value: 'no focus' ]).
	                aText ].

	aLabel := nil.
	^ BlExampleEventsCountingElement new
		  addChild: (aLabel := BlTextElement new
				             text: aTextBuilder value;
				             constraintsDo: [ :c |
					             c ignoreByLayout.
					             c ignored horizontal alignRight.
					             c padding: (BlInsets top: 5 right: 5) ]);
		  addEventHandler: (BlEventHandler
				   on: BlFocusInEvent
				   do: [ :anEvent |
					   hasFocus := true.
					   aLabel text: aTextBuilder value ]);
		  addEventHandler: (BlEventHandler
				   on: BlFocusOutEvent
				   do: [ :anEvent |
					   hasFocus := false.
					   aLabel text: aTextBuilder value ]);
		  addEventHandler: (BlEventHandler
				   on: BlFocusEvent
				   do: [ :anEvent |
					   isFocused := true.
					   aLabel text: aTextBuilder value ]);
		  addEventHandler: (BlEventHandler
				   on: BlBlurEvent
				   do: [ :anEvent |
					   isFocused := false.
					   aLabel text: aTextBuilder value ])
]

{ #category : 'examples - lose focus' }
BlFocusProcessorExamples >> loseFocus_01_give_focus_to_child_1 [

	<sampleInstance>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self scripterElement.

	aScripter substeps: 'Give focus to child-1' do: [ :aStep |
		aStep requestFocus onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in fired on child-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus fired on child-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-out not fired on child-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check blur not fired on child-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'child-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - lose focus' }
BlFocusProcessorExamples >> loseFocus_02_remove_child_1 [

	<sampleInstance>
	| aScripter aChild1 |
	aScripter := self loseFocus_01_give_focus_to_child_1.

	aChild1 := aScripter root childWithId: #'child-1'.
	aScripter set key: #'child-1' value: [ aChild1 ].

	aScripter substeps: 'Remove child-1' do: [ :aStep |
		aStep do
			action: [ :anElement | anElement removeFromParent ];
			id: #'child-1'.

		aStep check
			label: 'Check focus-in fired on child-1';
			value: [ aChild1 focusInCount ] equals: 1.

		aStep check
			label: 'Check focus fired on child-1';
			value: [ aChild1 focusCount ] equals: 1.

		aStep check
			label: 'Check focus-out not fired on child-1';
			value: [ aChild1 focusOutCount ] equals: 1.

		aStep check
			label: 'Check blur not fired on child-1';
			value: [ aChild1 blurCount ] equals: 1.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check container-1 is focused';
			satisfies: [ :anElement | anElement isFocused ];
			id: #'container-1'.

		aStep check
			label: 'Check child-1 is still marked as focused';
			satisfies: [ aChild1 isFocused ].

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'container-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - lose focus' }
BlFocusProcessorExamples >> loseFocus_03_add_back_child_1 [

	<sampleInstance>
	| aScripter aChild1 |
	aScripter := self loseFocus_02_remove_child_1.

	aChild1 := aScripter userData at: #'child-1'.

	aScripter substeps: 'Add child-1 back' do: [ :aStep |
		aStep do
			action: [ :anElement | anElement addChild: aChild1 ];
			id: #'container-1'.

		aStep check
			label: 'Check focus-in fired on child-1';
			value: [ aChild1 focusInCount ] equals: 2.

		aStep check
			label: 'Check focus fired on child-1';
			value: [ aChild1 focusCount ] equals: 2.

		aStep check
			label: 'Check focus-out not fired on child-1';
			value: [ aChild1 focusOutCount ] equals: 1.

		aStep check
			label: 'Check blur not fired on child-1';
			value: [ aChild1 blurCount ] equals: 1.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check child-1 is still marked as focused';
			satisfies: [ aChild1 isFocused ].

		aStep check
			label: 'Check container-1 is no longer focused';
			satisfies: [ :anElement | anElement isFocused not ];
			id: #'container-1'.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'child-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_01_parent [

	<sampleInstance>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self scripterElement.

	aScripter substeps: 'Request focus on parent' do: [ :aStep |
		aStep requestFocus.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_02_container_1 [

	<sampleInstance>
	| aScripter |
	aScripter := self requestFocus_01_parent.

	aScripter substeps: 'Request focus on container-1' do: [ :aStep |
		aStep requestFocus onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'container-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_03_container_2 [

	<sampleInstance>
	| aScripter |
	aScripter := self requestFocus_02_container_1.

	aScripter substeps: 'Request focus on container-2' do: [ :aStep |
		aStep requestFocus onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'container-2' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_04_child_1 [

	<sampleInstance>
	| aScripter |
	aScripter := self requestFocus_03_container_2.

	aScripter substeps: 'Request focus on child-1' do: [ :aStep |
		aStep requestFocus onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in fired on child-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus fired on child-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-out not fired on child-1';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check blur not fired on child-1';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 2;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'child-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_05_child_4 [

	<sampleInstance>
	| aScripter |
	aScripter := self requestFocus_04_child_1.

	aScripter substeps: 'Request focus on child-4' do: [ :aStep |
		aStep requestFocus onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus-in fired on child-4';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus fired on child-4';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus-out not fired on child-4';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check blur not fired on child-4';
			value: [ :anElement | anElement blurCount ] equals: 0;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus-in not fired on child-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus not fired on child-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-out fired on child-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check blur fired on child-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 2;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus not fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in not fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 2;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus not fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 2;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'child-4' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'examples - request focus' }
BlFocusProcessorExamples >> requestFocus_06_container_1 [

	<sampleInstance>
	| aScripter |
	aScripter := self requestFocus_05_child_4.

	aScripter substeps: 'Request focus on container-1' do: [ :aStep |
		aStep requestFocus onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in not fired on child-4';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus not fired on child-4';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus-out fired on child-4';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check blur fired on child-4';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'child-4'.

		aStep check
			label: 'Check focus-in not fired on child-1';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus not fired on child-1';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-out not fired on child-1';
			value: [ :anElement | anElement focusOutCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check blur not fired on child-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'child-1'.

		aStep check
			label: 'Check focus-in not fired on container-2';
			value: [ :anElement | anElement focusInCount ] equals: 2;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus not fired on container-2';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-out fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 2;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-2'.

		aStep check
			label: 'Check focus-in fired on container-1';
			value: [ :anElement | anElement focusInCount ] equals: 3;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus fired on container-1';
			value: [ :anElement | anElement focusCount ] equals: 2;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-out not fired on conatiner-1';
			value: [ :anElement | anElement focusOutCount ] equals: 2;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check blur not fired on container-1';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onChildNamed: #'container-1'.

		aStep check
			label: 'Check focus-in not fired';
			value: [ :anElement | anElement focusInCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus not fired';
			value: [ :anElement | anElement focusCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus-out not fired';
			value: [ :anElement | anElement focusOutCount ] equals: 0;
			onSelf.

		aStep check
			label: 'Check blur not fired';
			value: [ :anElement | anElement blurCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check focus owner';
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ]
			equals: [ aScripter element childWithId: #'container-1' ];
			onFocusProcessor ].

	^ aScripter syncContinue
]

{ #category : 'private - instance creation' }
BlFocusProcessorExamples >> scripterElement [

	<sampleInstance>
	^ self elementWithFocusHandler
		  size: 600 @ 400;
		  position: 50 @ 50;
		  border: (BlBorder paint: Color gray width: 1);
		  background: Color white;
		  id: #parent;
		  addChild: (BlTextElement new
				   text: ('#parent' asRopedText light fontSize: 11);
				   position: 8 @ 5);
		  addChildren: {
				  (self elementWithFocusHandler
					   id: #'container-1';
					   size: 240 @ 320;
					   position: 40 @ 40;
					   border: (BlBorder paint: Color gray width: 1);
					   background: (Color gray alpha: 0.1);
					   addChild: (BlTextElement new
							    text: ('#''container-1''' asRopedText light fontSize: 11);
							    position: 8 @ 5);
					   addChildren: {
							   (self elementWithFocusHandler
								    id: #'child-1';
								    size: 200 @ 130;
								    position: 20 @ 20;
								    background: (Color gray alpha: 0.3);
								    border: (BlBorder paint: Color lightGray width: 1);
								    addChild: (BlTextElement new
										     text: ('#''child-1''' asRopedText light fontSize: 11);
										     position: 8 @ 5)).

							   (self elementWithFocusHandler
								    id: #'child-2';
								    size: 200 @ 130;
								    position: 20 @ 170;
								    background: (Color gray alpha: 0.3);
								    border: (BlBorder paint: Color lightGray width: 1);
								    addChild: (BlTextElement new
										     text: ('#''child-2''' asRopedText light fontSize: 11);
										     position: 8 @ 5)) }).

				  (self elementWithFocusHandler
					   id: #'container-2';
					   size: 240 @ 320;
					   position: 320 @ 40;
					   border: (BlBorder paint: Color gray width: 1);
					   background: (Color gray alpha: 0.1);
					   addChild: (BlTextElement new
							    text: ('#''container-2''' asRopedText light fontSize: 11);
							    position: 8 @ 5);
					   addChildren: {
							   (self elementWithFocusHandler
								    id: #'child-3';
								    size: 200 @ 130;
								    position: 20 @ 20;
								    background: (Color gray alpha: 0.3);
								    border: (BlBorder paint: Color lightGray width: 1);
								    addChild: (BlTextElement new
										     text: ('#''child-3''' asRopedText light fontSize: 11);
										     position: 8 @ 5)).

							   (self elementWithFocusHandler
								    id: #'child-4';
								    size: 200 @ 130;
								    position: 20 @ 170;
								    background: (Color gray alpha: 0.3);
								    border: (BlBorder paint: Color lightGray width: 1);
								    addChild: (BlTextElement new
										     text: ('#''child-4''' asRopedText light fontSize: 11);
										     position: 8 @ 5)) }) }
]

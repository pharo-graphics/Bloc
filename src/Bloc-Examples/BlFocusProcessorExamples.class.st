Class {
	#name : #BlFocusProcessorExamples,
	#superclass : #BlEventProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'private - instance creation' }
BlFocusProcessorExamples >> elementWithFocusHandler [
	<gtExample>
	| aTextStyler hasFocus isFocused aTextBuilder aLabel |
	
	hasFocus := isFocused := false.
	aTextStyler := [ :aString | aString asRopedText light fontSize: 9 ].
	
	aTextBuilder := [
		| aText |
		
		aText := '' asRopedText.
		aText append: (isFocused
			ifTrue: [ (aTextStyler value: 'is focused') foreground: Color blue ]
			ifFalse: [ aTextStyler value: 'not focused' ]).
		aText append: (aTextStyler value: ' / ').
		aText append: (hasFocus
			ifTrue: [ (aTextStyler value: 'has focus') foreground: Color blue ]
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
		when: BlFocusInEvent do: [ :anEvent |
			hasFocus := true.
			aLabel text: aTextBuilder value ];
		when: BlFocusOutEvent do: [ :anEvent |
			hasFocus := false.
			aLabel text: aTextBuilder value ];
		when: BlFocusEvent do: [ :anEvent |
			isFocused := true.
			aLabel text: aTextBuilder value ];
		when: BlBlurEvent do: [ :anEvent |
			isFocused := false.
			aLabel text: aTextBuilder value ]
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_01_parent [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_02_container_1 [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element childNamed: #'container-1' ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_03_container_2 [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element childNamed: #'container-2' ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_04_child_1 [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element childNamed: #'child-1' ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_05_child_4 [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element childNamed: #'child-4' ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> requestFocus_06_container_1 [
	<gtExample>
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
			value: [ :aFocusProcessor | aFocusProcessor focusOwner ] equals: [ aScripter element childNamed: #'container-1' ];
			onFocusProcessor.
	].
	
	^ aScripter syncContinue
]

{ #category : #'examples - scripter' }
BlFocusProcessorExamples >> scripterElement [
	<gtExample>
	
	^ self elementWithFocusHandler
		size: 600@400;
		relocate: 50@50;
		border: (BlBorder paint: Color gray width: 1);
		background: Color white;
		containerName: #parent;
		addChild: (BlTextElement new text: ('#parent' asRopedText light fontSize: 11); relocate: 8@5);
		addChildren: { 
			self elementWithFocusHandler
				containerName: #'container-1';
				size: 240@320;
				relocate: 40@40;
				border: (BlBorder paint: Color gray width: 1);
				background: (Color gray alpha: 0.1);
				addChild: (BlTextElement new text: ('#''container-1''' asRopedText light fontSize: 11); relocate: 8@5);
				addChildren: { 
					self elementWithFocusHandler
						containerName: #'child-1';
						size: 200@130;
						relocate: 20@20;
						background: (Color gray alpha: 0.3);
						border: (BlBorder paint: Color lightGray width: 1);
						addChild: (BlTextElement new text: ('#''child-1''' asRopedText light fontSize: 11); relocate: 8@5).
						
					self elementWithFocusHandler
						containerName: #'child-2';
						size: 200@130;
						relocate: 20@170;
						background: (Color gray alpha: 0.3);
						border: (BlBorder paint: Color lightGray width: 1);
						addChild: (BlTextElement new text: ('#''child-2''' asRopedText light fontSize: 11); relocate: 8@5)
				}.
				
			self elementWithFocusHandler
				containerName: #'container-2';
				size: 240@320;
				relocate: 320@40;
				border: (BlBorder paint: Color gray width: 1);
				background: (Color gray alpha: 0.1);
				addChild: (BlTextElement new text: ('#''container-2''' asRopedText light fontSize: 11); relocate: 8@5);
				addChildren: { 
					self elementWithFocusHandler
						containerName: #'child-3';
						size: 200@130;
						relocate: 20@20;
						background: (Color gray alpha: 0.3);
						border: (BlBorder paint: Color lightGray width: 1);
						addChild: (BlTextElement new text: ('#''child-3''' asRopedText light fontSize: 11); relocate: 8@5).
						
					self elementWithFocusHandler
						containerName: #'child-4';
						size: 200@130;
						relocate: 20@170;
						background: (Color gray alpha: 0.3);
						border: (BlBorder paint: Color lightGray width: 1);
						addChild: (BlTextElement new text: ('#''child-4''' asRopedText light fontSize: 11); relocate: 8@5)
				}.
		}
]

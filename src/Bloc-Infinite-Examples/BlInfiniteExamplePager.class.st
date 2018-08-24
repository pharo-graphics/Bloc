Class {
	#name : #BlInfiniteExamplePager,
	#superclass : #BlElement,
	#instVars : [
		'list',
		'buttonLeft',
		'buttonRight'
	],
	#category : 'Bloc-Infinite-Examples-Core - Pager'
}

{ #category : #example }
BlInfiniteExamplePager class >> example [
	<gtExample>
	| pager |
	pager := BlInfiniteExamplePager new.

	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	pager list dataSource
		addPane: (BlInfiniteExamplePagerPane new title: 'Editor'; elementBlock: [ self tabsGroup ]);
		addPane: (BlInfiniteExamplePagerPane new
			title: 'Pane 1';
			elementBlock: [
				BlElement new
					size: 400@400;
					background: Color blue] );
		addPane: (BlInfiniteExamplePagerPane new
			title: 'Pane 2';
			elementBlock: [
				BlElement new
					constraintsDo: [:c |
						c horizontal matchParent .
						c vertical matchParent ];
					background: Color red]).
	^ pager
]

{ #category : #example }
BlInfiniteExamplePager class >> tabsGroup [
	<gtExample>
	
	| tabs styler editorText editor editorElement tab2 tab3 tab1 |
	tabs := BlInfiniteExamplePagerTabGroupElement new.
	tabs constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	styler := BrRBTextStyler new classOrMetaClass: Morph.
	editorText := (Morph>>#fullDrawOn:) sourceCode asRopedText.

	editor := BrTextEditor new.
	editor text: editorText.
	editor styler: styler.

	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editorElement background: Color white.
	editorElement margin: (BlInsets all: 10).

	tab1 := BlElement new
		size: 300@300;
		margin: (BlInsets all: 20);
		background: Color red.

	tab2 := BlElement new
		size: 300@300;
		margin: (BlInsets all: 20);
		background: Color blue.

	tab3 := BlElement new
		size: 400@400;
		margin: (BlInsets all: 20);
		background: Color green.
		
	tabs addTab: editorElement titled: 'Editor'.
	tabs addTab: tab1 titled: 'Tab 1'.
	tabs addTab: tab2 titled: 'Tab 2'.
	tabs addTab: tab3 titled: 'Tab 3'.

	^ tabs
]

{ #category : #initialization }
BlInfiniteExamplePager >> initialize [
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	
	list := BlInfiniteExamplePagerElement new.
	
	list constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	buttonLeft := BlTextElement new
		padding: (BlInsets all: 10);
		background: Color veryLightGray;
		text: (BrRopedText string: '< Left');
		addEventHandlerOn: BlClickEvent do: [ :anEvent |
			list smoothScrollBy: list width negated @ 0 ].
	buttonRight := BlTextElement new
		padding: (BlInsets all: 10);
		background: Color veryLightGray;
		text: (BrRopedText string: 'Right >');
		addEventHandlerOn: BlClickEvent do: [ :anEvent |
			list smoothScrollBy: list width @ 0 ].

	self addChildren: { buttonLeft . list . buttonRight }
]

{ #category : #accessing }
BlInfiniteExamplePager >> list [
	^ list
]

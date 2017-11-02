example
tabsGroup
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
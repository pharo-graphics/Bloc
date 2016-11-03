as yet unclassified
testChangeListener
	| p1 flag1 flag2 |
	p1 := BlObjectProperty new.
	flag1 := flag2 := false.
	p1 addChangeListener: (BlOnChangeListener do: [ flag1 := true ]).
	p1 onChangedDo: [ flag2 := true ].
	p1 value:#test.
	
	self assert: (flag1 and:flag2).
	
	p1 removeAllChangeListeners.
	flag1 := flag2 := false.
	p1 value:#test2.
	
	self assert: (flag1 not and:flag2 not).
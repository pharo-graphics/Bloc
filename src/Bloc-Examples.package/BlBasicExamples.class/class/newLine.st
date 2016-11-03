shape creation
newLine
	^ (BlLine from:10@10 to:100@100) asElement
		extent: 200@100;
		border: (BlBorder color: Color red width: 4);
		yourself
initialization
reset
	super reset.
	
	line := BrTextParagraphLine new.
	line baseline: self baseline.
	line paragraph: self
instance creation
measurer
	<gtExample>
	| aMeasurer |
	
	aMeasurer := BrTextParagraphFixedSpanMeasurer new.
	aMeasurer ascent: self ascent.
	aMeasurer descent: self descent.
	aMeasurer glyphWidth: self glyphWidth.
	aMeasurer height: self height.
	
	self assert: aMeasurer ascent equals: self ascent.
	self assert: aMeasurer descent equals: self descent.
	self assert: aMeasurer glyphWidth equals: self glyphWidth.
	self assert: aMeasurer height equals: self height.
	
	^ aMeasurer
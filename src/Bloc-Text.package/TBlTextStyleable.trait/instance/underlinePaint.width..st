api - text emphasis
underlinePaint: aPaint width: aNumber
	self attributesBuilder attribute: (
		BrTextUnderlineAttribute new 
			paint: aPaint;
			width: aNumber)
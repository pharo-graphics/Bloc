as yet unclassified
computedTransitions
	^ self transitions
		collect: [ :t | BlStyleTransition new
				selector: self selector;
				transition: t;
				yourself ]
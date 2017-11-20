accessing
metrics
	"Return a dictionary with segment metrics"
	<return: #Dictionary>
	
	^ {
		'Ascent' -> self ascent.
		'Descent' -> self descent.
		'Left' -> self left.
		'Top' -> self top.
		'Height' -> self height.
		'Width' -> self width.
		'Baseline' -> self baseline
	} asOrderedDictionary
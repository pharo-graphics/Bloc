accessing
managed: aBoolean
	"If false is provided, then the element is not subject to the parent's layout"
	self 
		deprecated: 'Use "constraintsDo: [ :c | c ignoreByLayout ]" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.

	self constraintsDo: [ :c |
		aBoolean
			ifTrue: [ c accountByLayout ]
			ifFalse: [ c ignoreByLayout ] ]
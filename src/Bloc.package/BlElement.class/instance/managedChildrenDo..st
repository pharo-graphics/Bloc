children accessing
managedChildrenDo: aBlock
   "Evaluate aBlock with each of my direct managed children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	self 
		deprecated: 'Use "children accountedByLayout do:" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self children accountedByLayout do: aBlock
visiting
visitCompulsory: aBlCompulsoryCombination
	| combinations pairedAlternatives compulsory |
	
	"every element in combinations set is alternative,
	however there is a logical AND between all of them"
	combinations := aBlCompulsoryCombination combinations
		collect: [ :aCombination | aCombination accept: self ].
		
	self
		assert: [ combinations isNotEmpty ]
		description: [ 'Combinations can not be empty!' ].

	combinations size = 1
		ifTrue: [ ^ combinations first ].

	pairedAlternatives := combinations pairsCollect: [ :left :right |
		BlAlternativeCombination new withAll: (left combinations collect: [ :eachLeft |
			right combinations collect: [ :eachRight |
				BlCompulsoryCombination new withAll: { eachLeft . eachRight } ] ]) flattened ].
	
	combinations size = 2
		ifTrue: [ ^ pairedAlternatives first ].
	
	compulsory := BlCompulsoryCombination new.
	compulsory withAll: pairedAlternatives. 
	combinations size odd
		ifTrue: [ compulsory with: combinations last ].	
	
	^ compulsory accept: self
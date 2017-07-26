visiting
visitAlternative: aBlAlternativeCombination
	| combinations pairedCompulsories alternative |

	"every element in combinations set is compulsory,
	however there is a logical OR between all of them"
	combinations := aBlAlternativeCombination combinations
		collect: [ :aCombination | aCombination accept: self ].

	self
		assert: [ combinations isNotEmpty ]
		description: [ 'Combinations can not be empty!' ].

	combinations size = 1
		ifTrue: [ ^ combinations first ].

	pairedCompulsories := combinations pairsCollect: [ :left :right |
		BlCompulsoryCombination new withAll: (left combinations collect: [ :eachLeft |
			right combinations collect: [ :eachRight |
				BlAlternativeCombination new withAll: { eachLeft . eachRight } ] ]) flattened ].
	
	combinations size = 2
		ifTrue: [ ^ pairedCompulsories first ].
	
	alternative := BlAlternativeCombination new.
	alternative withAll: pairedCompulsories. 
	combinations size odd
		ifTrue: [ alternative with: combinations last ].	
	
	^ alternative accept: self.
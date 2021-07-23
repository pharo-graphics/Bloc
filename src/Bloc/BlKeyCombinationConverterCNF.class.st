"
I transform composite key combination formula into a CNF (https://en.wikipedia.org/wiki/Conjunctive_normal_form)

"
Class {
	#name : 'BlKeyCombinationConverterCNF',
	#superclass : 'BlKeyCombinationVisitor',
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : 'visiting' }
BlKeyCombinationConverterCNF >> visitAlternative: aBlAlternativeCombination [
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
]

{ #category : 'visiting' }
BlKeyCombinationConverterCNF >> visitCompulsory: aBlCompulsoryCombination [
	| compulsory |

	compulsory := BlCompulsoryCombination new.

	aBlCompulsoryCombination combinations do: [ :aCombination |
		compulsory withAll: (aCombination accept: self) combinations ].
	
	^ compulsory
]

{ #category : 'visiting' }
BlKeyCombinationConverterCNF >> visitKey: aBlKeyCodeCombination [
	^ BlCompulsoryCombination new with: aBlKeyCodeCombination
]

Extension { #name : 'BlCompositeBackground' }

{ #category : '*Bloc-Alexandrie' }
BlCompositeBackground >> aeApplyTo: aeCanvas [
	"Draw all backgrounds in add order"
	
	backgrounds do:[ :b | b aeApplyTo: aeCanvas ].
]

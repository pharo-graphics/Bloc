Extension { #name : #BlCompositeBackground }

{ #category : #'*Bloc-Alexandrie' }
BlCompositeBackground >> aeApplyTo: aeCanvas [
	"Draw all backgrounds in add order"

	self backgrounds do: [ :background | background aeApplyTo: aeCanvas ]
]

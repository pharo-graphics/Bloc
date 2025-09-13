Extension { #name : #BlFormSetBackground }

{ #category : #'*Bloc-Alexandrie' }
BlFormSetBackground >> aeApplyTo: aeCanvas [

	aeCanvas setBackgroundWithFormSet: self formSet alpha: self opacity
]

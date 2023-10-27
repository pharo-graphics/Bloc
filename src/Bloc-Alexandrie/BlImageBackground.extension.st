Extension { #name : 'BlImageBackground' }

{ #category : '*Bloc-Alexandrie' }
BlImageBackground >> aeApplyTo: aeCanvas [

	aeCanvas setBackgroundWithForm: self image alpha: self opacity
]

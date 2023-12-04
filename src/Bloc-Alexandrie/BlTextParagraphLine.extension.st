Extension { #name : 'BlTextParagraphLine' }

{ #category : '*Bloc-Alexandrie' }
BlTextParagraphLine >> aeDrawOn: aeCanvas [

	self spans do: [ :aSpan | aSpan aeDrawOn: aeCanvas ]
]

Extension { #name : 'Object' }

{ #category : '*Bloc-Text-Rope' }
Object >> asRopedText [
	^ BlRopedText string: self asString
]

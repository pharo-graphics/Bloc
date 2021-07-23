Extension { #name : 'String' }

{ #category : '*Bloc' }
String >> asBlocElementId [
	<return: #BlElementId>

	^ BlElementId named: self asSymbol
]

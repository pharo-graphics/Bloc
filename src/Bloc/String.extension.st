Extension { #name : #String }

{ #category : #'*Bloc' }
String >> asBlocElementId [

	^ BlElementId named: self asSymbol
]

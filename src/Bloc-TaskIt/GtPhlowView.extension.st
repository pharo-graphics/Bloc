Extension { #name : #GtPhlowView }

{ #category : #'*Bloc-TaskIt' }
GtPhlowView >> taskItExplicitView [
	^ GtPhlowTaskItExplicitView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

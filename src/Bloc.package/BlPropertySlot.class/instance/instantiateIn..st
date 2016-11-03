as yet unclassified
instantiateIn: anObject
	| prop |
	prop := self propertyClass on: anObject named: self name.
	self write: prop to: anObject.
	^ prop
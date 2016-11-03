accessing
applyOn: aTarget property: aSymbol
	| valueToApply |
	valueToApply := self computeValueFrom: aTarget property: aSymbol.
	(self transition isNil or: [ self transition duration = 0 ])
		ifTrue: [ self apply: valueToApply on: aTarget property: aSymbol ]
		ifFalse: [ self transite: valueToApply on: aTarget property: aSymbol ]
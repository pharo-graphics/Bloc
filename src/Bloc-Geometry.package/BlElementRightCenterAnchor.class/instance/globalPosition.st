geometry
globalPosition
	| bounds |
	bounds := self referenceElement boundsInSpace. 
	^ bounds right @ (bounds top + (bounds height / 2.0))
geometry
globalPosition
	| bounds |
	bounds := self referenceElement boundsInSpace. 
	^ bounds left @ (bounds top + (bounds height / 2.0))
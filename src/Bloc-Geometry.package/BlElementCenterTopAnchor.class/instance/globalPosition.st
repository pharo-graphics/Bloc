geometry
globalPosition
	| bounds |
	bounds := self referenceElement boundsInSpace. 
	^ (bounds left + (bounds width / 2.0)) @ bounds top
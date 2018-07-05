rope - deleting
delete: aStart to: anEnd
	| afterDeletion |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	afterDeletion := self rope delete: aStart + offset to: anEnd + offset.
	^ afterDeletion
		from: offset + 1
		to: offset + length - (anEnd - aStart + 1)
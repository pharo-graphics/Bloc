private
computeOffset: anIndex
	"Compute an offset from item index within data source to child index within infinite element"
	| aLimit anOffset |

	anIndex <= 0
		ifTrue: [ ^ 0 ].
	
	aLimit := controller childrenCount.
	anOffset := anIndex.
	
	[ anOffset <= aLimit ] whileTrue: [ 
		| removedBefore diff |
		removedBefore := bucket countOnesBefore: anOffset.
		diff := anIndex - (anOffset - removedBefore).
		diff = 0
			ifTrue: [ 
				[ bucket get: anOffset ]
					whileTrue: [ anOffset := anOffset + 1 ].
				^ anOffset ]
		ifFalse: [ anOffset := anOffset + diff ] ].
	^ 0
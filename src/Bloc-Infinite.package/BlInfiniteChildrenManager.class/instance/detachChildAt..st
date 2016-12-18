children add/remove
detachChildAt: anIndex
	"Detaches a child element at anIndex from infinite element"
	| anOffset |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].
	
	bucket remove: anOffset.
	controller detachChildAt: anOffset
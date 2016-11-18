children add/remove
detachChildAt: anIndex
	"Detaches a child element at anIndex from infinite element"
	| offset |
	
	offset := self computeOffset: anIndex.
	bucket remove: offset.
	controller detachChildAt: offset
children add/remove
detachChildAt: index
	| offset |
	offset := self computeOffset: index.
	bucket remove: offset.	
	controller detachChildAt: offset
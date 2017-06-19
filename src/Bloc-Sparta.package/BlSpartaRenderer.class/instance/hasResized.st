renderer - testing
hasResized
	"Return true if host space resized since previous frame, otherwise false"
	<return: #Boolean>
	
	^ session ~= Smalltalk session
		or: [ self surface windowExtent ~= windowExtent
			or: [ self surface canvasExtent ~= canvasExtent ] ]
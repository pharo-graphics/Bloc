testing
isSplitted
	"Return true if span I measure is splitted right after me. This may happen
	if a single span does not fit in a line and we have to push next paragraph span
	on the next paragraph line"
	<return: #Boolean>
	
	^ spanEnd < span size
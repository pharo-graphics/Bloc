children - accessing
at: anIndex
	<return: #BlElement>
	
	^ childrenArray at: (childrenArray size - anIndex + 1)
children - accessing
at: anIndex
	<return: #BlElement>

	^ super at: (self size - anIndex + 1)
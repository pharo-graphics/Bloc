printing
printOn: aStream
	alternative do:[:each| aStream print:each] separatedBy:[aStream nextPutAll:' | '].
	
printing
printOn: aStream
	sequence do:[:each| aStream print:each] separatedBy:[aStream nextPutAll:' , '].
	
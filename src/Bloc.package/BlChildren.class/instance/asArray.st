children - converting
asArray
	<return: #Array of: #BlElement>
	
	^ Array new: self size streamContents: [ :aStream | self do: [ :anElement | aStream nextPut: anElement ] ]
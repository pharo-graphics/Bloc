rope - streaming
putOn: aStream from: aStart to: anEnd
	self from: aStart to: anEnd do: [ :anItem | aStream nextPut: anItem ]
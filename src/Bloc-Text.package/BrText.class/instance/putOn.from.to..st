text - printing
putOn: aWriteStream from: aStart to: anEnd
	self
		from: aStart
		to: anEnd
		do: [ :aChar | aWriteStream nextPut: aChar ]
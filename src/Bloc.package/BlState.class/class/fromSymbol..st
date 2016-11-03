converting
fromSymbol: aSymbol
	self
		subclassesDo: [ :aClass | 
			aClass asSymbol = aSymbol
				ifTrue: [ ^ aClass ] ]
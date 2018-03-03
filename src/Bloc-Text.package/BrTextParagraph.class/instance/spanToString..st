paragraph - replacement
spanToString: aBrText
	"Convert a given text span to a string replacing tabs and special character with the ones that should
	be measured and rendered"
	<return: #String>

	^ String streamContents: [ :aStream |
		aBrText do: [ :aChar |
			aChar = Character tab
				ifTrue: [ self tabWidth timesRepeat: [ aStream nextPut: Character space ] ]
				ifFalse: [ aStream nextPut: aChar ] ] ]
private
generateFlagName: aString

	^ String streamContents: [ :aStream |
			aString asLowercase
				splitOn: '_'
				do: [ :aPart | aStream nextPutAll: aPart capitalized ] ]
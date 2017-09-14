instance creation
fromHexString: aColorHex
	|stream|
	stream := WriteStream on:''.
	aColorHex size = 3 ifTrue:[ aColorHex do: [:character | 2 timesRepeat: [stream nextPut:character] ]]
							ifFalse:[ stream nextPutAll: aColorHex ].
	
	^super fromHexString: stream contents.
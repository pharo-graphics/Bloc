Extension { #name : 'BlElement' }

{ #category : '*Bloc-Scripter' }
BlElement >> devScripterData [
	<return: #BlDevScripterUserData>
	self 
		assert: [ self space isNotNil ] 
		description: [ 'Element must be in a space in order to access Scripter data' ].
	^ self space root userData at: #devScripterData ifAbsentPut: [ BlDevScripterUserData new ]
]

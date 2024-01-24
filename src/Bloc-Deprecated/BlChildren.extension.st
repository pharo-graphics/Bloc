Extension { #name : #BlChildren }

{ #category : #'*Bloc-Deprecated' }
BlChildren >> all [
	self 
		deprecated: 'Use asArray instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
	^ self asArray
]

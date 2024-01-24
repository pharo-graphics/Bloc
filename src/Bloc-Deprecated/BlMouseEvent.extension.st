Extension { #name : #BlMouseEvent }

{ #category : #'*Bloc-Deprecated' }
BlMouseEvent class >> middleButton [
	self 
		deprecated: 'Use `BlMouseButton middle` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton middle
]

{ #category : #'*Bloc-Deprecated' }
BlMouseEvent class >> primaryButton [
	self 
		deprecated: 'Use `BlMouseButton primary` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton primary
]

{ #category : #'*Bloc-Deprecated' }
BlMouseEvent class >> secondaryButton [
	self 
		deprecated: 'Use `BlMouseButton secondary` instead'
		on: 	'17 January 2018' 
		in: 'Pharo-6.0-60520-'.
	^ BlMouseButton secondary
]

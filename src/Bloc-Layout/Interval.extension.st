Extension { #name : 'Interval' }

{ #category : '*Bloc-Layout' }
Interval >> inversed [
	^ self class from: stop to: start by: step
]

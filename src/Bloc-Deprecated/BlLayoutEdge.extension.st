Extension { #name : #BlLayoutEdge }

{ #category : #'*Bloc-Deprecated' }
BlLayoutEdge >> fromElement [
	self
		deprecated: 'Use #fromNode instead'
		transformWith: '`@receiver fromElement' -> '`@receiver fromNode'.
		
	^ self fromNode
]

{ #category : #'*Bloc-Deprecated' }
BlLayoutEdge >> toElement [
	self
		deprecated: 'Use #toNode instead'
		transformWith: '`@receiver toElement' -> '`@receiver toNode'.
		
	^ self toNode
]

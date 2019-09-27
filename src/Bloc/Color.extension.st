Extension { #name : #Color }

{ #category : #'*Bloc' }
Color >> asBlBackground [
	^ BlBackground paint: self
]

{ #category : #'*Bloc' }
Color >> asBlPaint [
	^ BlColorPaint color: self
]

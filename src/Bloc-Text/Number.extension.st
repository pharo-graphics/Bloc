Extension { #name : 'Number' }

{ #category : '*Bloc-Text' }
Number >> fontEm [
	^ BlFontSize em: self
]

{ #category : '*Bloc-Text' }
Number >> fontPercent [
	^ BlFontSize percent: self
]

{ #category : '*Bloc-Text' }
Number >> fontPt [
	^ BlFontSize pt: self
]

{ #category : '*Bloc-Text' }
Number >> fontRem [
	^ BlFontSize rem: self
]

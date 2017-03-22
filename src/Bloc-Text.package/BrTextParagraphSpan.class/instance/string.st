accessing
string
	^ String streamContents: [ :aStream | span putOn: aStream from: start to: end ]
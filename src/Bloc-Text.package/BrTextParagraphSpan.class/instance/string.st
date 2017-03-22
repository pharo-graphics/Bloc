accessing
string
	^ String streamContents: [ :aStream | span putOn: aStream from: textRunStart to: textRunEnd ]
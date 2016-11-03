grammar media
mediaConditions
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
accessing
animation
	^ animation ifNil: [ animation := self defaultAnimation ]
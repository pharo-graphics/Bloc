accessing
styleProperties
	^ styleProperties ifNil: [ styleProperties := self class styleProperties ]
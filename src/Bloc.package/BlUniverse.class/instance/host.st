accessing
host
	^ preferableHost ifNil: [ BlHost current ]
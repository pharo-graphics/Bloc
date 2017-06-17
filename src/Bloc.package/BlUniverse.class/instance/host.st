accessing
host
	^ preferableHost ifNil: [ BlHost pickHost ]
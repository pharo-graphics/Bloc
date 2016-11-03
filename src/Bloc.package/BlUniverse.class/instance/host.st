accessing
host
	^ host ifNil:[host := self defaultHost]
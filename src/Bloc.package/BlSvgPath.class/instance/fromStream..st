instance creation
fromStream: aStream
	self pathData: (ASPathConverter new stream: aStream readStream) convertPathData
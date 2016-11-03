instance creation
fromStream: aStream
	self pathData: (BlSvgPathConverter new stream: aStream readStream) convertPathData
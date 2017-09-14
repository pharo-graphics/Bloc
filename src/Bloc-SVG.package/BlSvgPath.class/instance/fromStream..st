instance creation
fromStream: aStream
	self pathData: (BlSvgPathBuilder new stream: aStream readStream) convertedPathData
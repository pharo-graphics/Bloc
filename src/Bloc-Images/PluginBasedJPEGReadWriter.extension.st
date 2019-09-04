Extension { #name : #PluginBasedJPEGReadWriter }

{ #category : #'*Bloc-Images' }
PluginBasedJPEGReadWriter class >> gtFromBuffer: aByteArray [

	^self new gtFromBuffer: aByteArray
]

{ #category : #'*Bloc-Images' }
PluginBasedJPEGReadWriter >> gtFromBuffer: bytes [
	"Decode and answer a Form of the given depth from my stream. Close the stream if it is a file stream. Possible depths are 16-bit and 32-bit."
	| width height form jpegDecompressStruct jpegErrorMgr2Struct depthToUse depth |
	depth := Display depth.
	jpegDecompressStruct := ByteArray new: self primJPEGDecompressStructSize.
	jpegErrorMgr2Struct := ByteArray new: self primJPEGErrorMgr2StructSize.
	self 
		primJPEGReadHeader: jpegDecompressStruct
		fromByteArray: bytes
		errorMgr: jpegErrorMgr2Struct.
	width := self primImageWidth: jpegDecompressStruct.
	height := self primImageHeight: jpegDecompressStruct.
	"Odd width images of depth 16 gave problems. Avoid them (or check carefully!)"
	depthToUse := depth = 32 | width odd 
		ifTrue: [ 32 ]
		ifFalse: [ 16 ].
	form := Form 
		extent: width @ height
		depth: depthToUse.
	(width = 0 or: [ height = 0 ]) ifTrue: [ ^ form ].
	self 
		primJPEGReadImage: jpegDecompressStruct
		fromByteArray: bytes
		onForm: form
		doDithering: true
		errorMgr: jpegErrorMgr2Struct.
	^ form
]

text - notifying
announcerDo: aBlockClosure
	"Evaluate a given block closure with an announcer as an argument if it is initialized"
	announcer ifNotNil: aBlockClosure
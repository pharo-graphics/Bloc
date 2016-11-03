*Bloc-Athens
drawOnAthensCanvas: aCanvas
	|lv|
	self drawPathOnAthensCanvas: aCanvas.
	lv :=  TxAthensLayoutView on: self text asTxModel extent: self extent.
	lv layoutStrategy: TxAthensCharacterWrappingStrategy new.
	lv extent: self extent.
	lv renderOn:aCanvas
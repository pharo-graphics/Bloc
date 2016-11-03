initialization
initialize
	super initialize.
	fill := self defaultFill. 
	stroke := self defaultStroke.
	wrappingWidth := 0.
	layoutView := TxAthensLayoutView new.
	layoutView container: self.
	textModel := '' asTxModel.
	layoutView initWithPosition: textModel startPosition extent: self extent. 
	layoutView layoutStrategy: TxAthensNoWrapStrategy new.
	
actions
hideInfo

	self padding: BlInsets empty.
	self relocate: self selectionPosition.
	self size: self selectionExtent.
	
	self effect: BlNullEffect new.
	self background: self defaultBackground.
	self removeChild: marginElement.
	self removeChild: paddingElement.
	self removeChild: extentElement.
	hasInformation := false
event testing
canBeDblClickEvent: aMouseUpEvent
	^ ((self canBeClickEvent: aMouseUpEvent) and:[lastClickEvent isNotNil])
		and: [ aMouseUpEvent timestamp - lastClickEvent timestamp < self dblClickDelay ]
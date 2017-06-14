window - properties
resizable: aBoolean
	"Make underlying window resizable if true is given"
	
	resizable := aBoolean.
	self hostSpace ifNotNil: [ :aHostSpace | aHostSpace resizable: aBoolean ]
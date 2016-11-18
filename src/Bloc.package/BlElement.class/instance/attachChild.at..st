children add/remove
attachChild: anElement at: anIndex
	"Attaches an element making it my direct child. Attaching an element assigns me as the parent
	and puts an element in the list of children so that it can be retrieved by `children at:`.
   I am intended to be lightweight and make no assumptions about whether the parent or child should be redrawn.
	Proper use includes also making any appropriate #requestLayout or #changed message sends.
   I should only be used for elements which were detached from me as their previous parent.
	anElement must not be nil.
	anElement must not be my direct child.
	anIndex must be within my childrens' array"
	self assert: anElement isNotNil.
	self assert: anElement parent isNil.
	self assert: anIndex > 0.
	self assert: anIndex <= (self children size + 1).

	anElement parent: self.
	self children add: anElement at: anIndex
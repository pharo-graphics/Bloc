children hooks
onRemovedFromParent
	"I am sent after I was removed from my parent.
	At this point sending #parent to myself will result in nil.
	Note: Always send onRemovedFromParent to super class if you override me!"
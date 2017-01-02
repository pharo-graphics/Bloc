displaying
close
	BlUniverse default closeSpaceWindow: self.
	hostSpace := nil.
	"Notify root element that it is no longer in scene graph"
	root dispatchRemovedFromSceneGraph
hooks - geometry
onPositionInSpaceChanged
	"Is sent when my position in space changed because I or any of my parents moved.
	Override me to perform additional actions, always send #onPositionInSpaceChanged super.
	aSourceElement is an element that was originally moved within its local bounds"

	self notifyPositionInSpaceChanged
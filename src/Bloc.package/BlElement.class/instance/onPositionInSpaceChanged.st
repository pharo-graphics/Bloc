geometry hooks
onPositionInSpaceChanged
	"Is sent when my position in space changed because I or any of my parents moved.
	Override me to perform additional actions, always send #onPositionInSpaceChanged super"

	self notifyPositionInSpaceChanged.
	self childrenDo: [ :anElement | anElement onPositionInSpaceChanged ]
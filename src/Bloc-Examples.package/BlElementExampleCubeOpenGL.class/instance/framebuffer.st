accessing
framebuffer

	"^ fb ifNil: [ fb := self context offscreenBufferExtent: self extent ]"
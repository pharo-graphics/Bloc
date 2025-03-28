Extension { #name : #'SDL_Texture' }

{ #category : #'*BlocHost-OSWindow-SDL2' }
SDL_Texture >> lockRect: rect pixels: pixelsAddress pitch: pitchAddress [
	"See: https://wiki.libsdl.org/SDL2/SDL_LockTexture"

	^ self ffiCall: #(
		int
		SDL_LockTexture (
			self,
			SDL_Rect* rect,
			void** pixelsAddress,
			int* pitchAddress ) )
]

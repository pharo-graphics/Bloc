*BlocHost-SDL
getDisplay: anIndex ddpi: ddpi hdpi: hdpi vdpi: vdpi

	^ self ffiCall: #( void SDL_GetDisplayDPI ( int anIndex , float* ddpi , float* hdpi, float* vdpi ) )
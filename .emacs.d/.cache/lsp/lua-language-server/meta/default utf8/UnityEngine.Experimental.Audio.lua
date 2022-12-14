---@meta

--
--Provides access to the audio samples generated by Unity objects such as VideoPlayer.
--
---@source UnityEngine.AudioModule.dll
---@class UnityEngine.Experimental.Audio.AudioSampleProvider: object
--
--Unique identifier for this instance.
--
---@source UnityEngine.AudioModule.dll
---@field id uint
--
--Index of the track in the object that created this provider.
--
---@source UnityEngine.AudioModule.dll
---@field trackIndex ushort
--
--Object where this provider came from.
--
---@source UnityEngine.AudioModule.dll
---@field owner UnityEngine.Object
--
--True if the object is valid.
--
---@source UnityEngine.AudioModule.dll
---@field valid bool
--
--The number of audio channels per sample frame.
--
---@source UnityEngine.AudioModule.dll
---@field channelCount ushort
--
--The expected playback rate for the sample frames produced by this class.
--
---@source UnityEngine.AudioModule.dll
---@field sampleRate uint
--
--The maximum number of sample frames that can be accumulated inside the internal buffer before an overflow event is emitted.
--
---@source UnityEngine.AudioModule.dll
---@field maxSampleFrameCount uint
--
--Number of sample frames available for consuming with Experimental.Audio.AudioSampleProvider.ConsumeSampleFrames.
--
---@source UnityEngine.AudioModule.dll
---@field availableSampleFrameCount uint
--
--Number of sample frames that can still be written to by the sample producer before overflowing.
--
---@source UnityEngine.AudioModule.dll
---@field freeSampleFrameCount uint
--
--Then the free sample count falls below this threshold, the Experimental.Audio.AudioSampleProvider.sampleFramesAvailable event and associated native is emitted.
--
---@source UnityEngine.AudioModule.dll
---@field freeSampleFrameCountLowThreshold uint
--
--Enables the Experimental.Audio.AudioSampleProvider.sampleFramesAvailable events.
--
---@source UnityEngine.AudioModule.dll
---@field enableSampleFramesAvailableEvents bool
--
--If true, buffers produced by ConsumeSampleFrames will get padded when silence if there are less available than asked for. Otherwise, the extra sample frames in the buffer will be left unchanged.
--
---@source UnityEngine.AudioModule.dll
---@field enableSilencePadding bool
--
--Pointer to the native function that provides access to audio sample frames.
--
---@source UnityEngine.AudioModule.dll
---@field consumeSampleFramesNativeFunction UnityEngine.Experimental.Audio.AudioSampleProvider.ConsumeSampleFramesNativeFunction
---@source UnityEngine.AudioModule.dll
---@field sampleFramesAvailable UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
---@source UnityEngine.AudioModule.dll
---@field sampleFramesOverflow UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
---@source UnityEngine.AudioModule.dll
CS.UnityEngine.Experimental.Audio.AudioSampleProvider = {}

--
--Release internal resources. Inherited from IDisposable.
--
---@source UnityEngine.AudioModule.dll
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.Dispose() end

---@source UnityEngine.AudioModule.dll
---@param sampleFrames Unity.Collections.NativeArray<float>
---@return UInt32
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.ConsumeSampleFrames(sampleFrames) end

---@source UnityEngine.AudioModule.dll
---@param value UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.add_sampleFramesAvailable(value) end

---@source UnityEngine.AudioModule.dll
---@param value UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.remove_sampleFramesAvailable(value) end

---@source UnityEngine.AudioModule.dll
---@param value UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.add_sampleFramesOverflow(value) end

---@source UnityEngine.AudioModule.dll
---@param value UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesHandler
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.remove_sampleFramesOverflow(value) end

---@source UnityEngine.AudioModule.dll
---@param handler UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesEventNativeFunction
---@param userData System.IntPtr
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.SetSampleFramesAvailableNativeHandler(handler, userData) end

--
--Clear the native handler set with Experimental.Audio.AudioSampleProvider.SetSampleFramesAvailableNativeHandler.
--
---@source UnityEngine.AudioModule.dll
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.ClearSampleFramesAvailableNativeHandler() end

---@source UnityEngine.AudioModule.dll
---@param handler UnityEngine.Experimental.Audio.AudioSampleProvider.SampleFramesEventNativeFunction
---@param userData System.IntPtr
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.SetSampleFramesOverflowNativeHandler(handler, userData) end

--
--Clear the native handler set with Experimental.Audio.AudioSampleProvider.SetSampleFramesOverflowNativeHandler.
--
---@source UnityEngine.AudioModule.dll
function CS.UnityEngine.Experimental.Audio.AudioSampleProvider.ClearSampleFramesOverflowNativeHandler() end


--
--Type that represents the native function pointer for consuming sample frames.
--
--```plaintext
--Params: providerId - Id of the provider. See Experimental.Audio.AudioSampleProvider.id.
--        interleavedSampleFrames - Pointer to the sample frames buffer to fill. The actual C type is float*.
--        sampleFrameCount - Number of sample frames that can be written into interleavedSampleFrames.
--        
--```
--
---@source UnityEngine.AudioModule.dll
---@class UnityEngine.Experimental.Audio.ConsumeSampleFramesNativeFunction: System.MulticastDelegate
---@source UnityEngine.AudioModule.dll
CS.UnityEngine.Experimental.Audio.ConsumeSampleFramesNativeFunction = {}

---@source UnityEngine.AudioModule.dll
---@param providerId uint
---@param interleavedSampleFrames System.IntPtr
---@param sampleFrameCount uint
---@return UInt32
function CS.UnityEngine.Experimental.Audio.ConsumeSampleFramesNativeFunction.Invoke(providerId, interleavedSampleFrames, sampleFrameCount) end

---@source UnityEngine.AudioModule.dll
---@param providerId uint
---@param interleavedSampleFrames System.IntPtr
---@param sampleFrameCount uint
---@param callback System.AsyncCallback
---@param object object
---@return IAsyncResult
function CS.UnityEngine.Experimental.Audio.ConsumeSampleFramesNativeFunction.BeginInvoke(providerId, interleavedSampleFrames, sampleFrameCount, callback, object) end

---@source UnityEngine.AudioModule.dll
---@param result System.IAsyncResult
---@return UInt32
function CS.UnityEngine.Experimental.Audio.ConsumeSampleFramesNativeFunction.EndInvoke(result) end


--
--Delegate for sample frame events.
--
--```plaintext
--Params: provider - Provider emitting the event.
--        sampleFrameCount - How many sample frames are available, or were dropped, depending on the event.
--        
--```
--
---@source UnityEngine.AudioModule.dll
---@class UnityEngine.Experimental.Audio.SampleFramesHandler: System.MulticastDelegate
---@source UnityEngine.AudioModule.dll
CS.UnityEngine.Experimental.Audio.SampleFramesHandler = {}

---@source UnityEngine.AudioModule.dll
---@param provider UnityEngine.Experimental.Audio.AudioSampleProvider
---@param sampleFrameCount uint
function CS.UnityEngine.Experimental.Audio.SampleFramesHandler.Invoke(provider, sampleFrameCount) end

---@source UnityEngine.AudioModule.dll
---@param provider UnityEngine.Experimental.Audio.AudioSampleProvider
---@param sampleFrameCount uint
---@param callback System.AsyncCallback
---@param object object
---@return IAsyncResult
function CS.UnityEngine.Experimental.Audio.SampleFramesHandler.BeginInvoke(provider, sampleFrameCount, callback, object) end

---@source UnityEngine.AudioModule.dll
---@param result System.IAsyncResult
function CS.UnityEngine.Experimental.Audio.SampleFramesHandler.EndInvoke(result) end


--
--Type that represents the native function pointer for handling sample frame events.
--
--```plaintext
--Params: userData - User data specified when the handler was set. The actual C type is void*.
--        providerId - Id of the provider. See Experimental.Audio.AudioSampleProvider.id.
--        sampleFrameCount - Number of sample frames available or overflowed, depending on event type.
--        
--```
--
---@source UnityEngine.AudioModule.dll
---@class UnityEngine.Experimental.Audio.SampleFramesEventNativeFunction: System.MulticastDelegate
---@source UnityEngine.AudioModule.dll
CS.UnityEngine.Experimental.Audio.SampleFramesEventNativeFunction = {}

---@source UnityEngine.AudioModule.dll
---@param userData System.IntPtr
---@param providerId uint
---@param sampleFrameCount uint
function CS.UnityEngine.Experimental.Audio.SampleFramesEventNativeFunction.Invoke(userData, providerId, sampleFrameCount) end

---@source UnityEngine.AudioModule.dll
---@param userData System.IntPtr
---@param providerId uint
---@param sampleFrameCount uint
---@param callback System.AsyncCallback
---@param object object
---@return IAsyncResult
function CS.UnityEngine.Experimental.Audio.SampleFramesEventNativeFunction.BeginInvoke(userData, providerId, sampleFrameCount, callback, object) end

---@source UnityEngine.AudioModule.dll
---@param result System.IAsyncResult
function CS.UnityEngine.Experimental.Audio.SampleFramesEventNativeFunction.EndInvoke(result) end

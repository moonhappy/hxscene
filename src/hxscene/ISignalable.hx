package hxscene;

/**
 * Interface of a Signalable type.
 * 
 * Has methods to call to register and invoke signal cues.
 */
interface ISignalable {

	/**
	 * List of registered cues being monitored and the associated callback functions.
	 * 
	 * @return Map of all cues and associated callback functions that are registered.
	 */
	public function cues():Map<Int, Array<(Any)->Void>>;

	/**
	 * Registers a cue for the object to monitor for and act on call.
	 * 
	 * @param cueID The unique ID of the cue.
	 * @param callback Reference to the callback function to invoke when the cue is called.
	 */
	public function registerCue(cueID:Int, callback:(Any)->Void):Void;

	/**
	 * Unregister a cue from the object.
	 * 
	 * @param cueID The unique ID of the cue.
	 * @param callback Reference to the callback function to invoke when the cue is called.
	 */
	public function unregisterCue(cueID:Int, callback:(Any)->Void):Void;

	/**
	 * Calls a cue.
	 * 
	 * @param cueID The unique ID of the cue.
	 * @param userData Additional data to pass to the cue function.
	 * @param director Reference to the invoking director.
	 */
	public function signalCue(cueID:Int, userData:Any, ?director:IDirectorable = null):Void;

}

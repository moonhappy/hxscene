package hxscene;

/**
 * Interface of an Updateable type.
 * 
 * Has methods to call on update cycle of the game loop.
 */
interface IUpdateable {

	/**
	 * Current state of whether the object is active or not. If active, `update()` will be called during the update cycle.
	 * 
	 * @return The current state of whether the object is active or not.
	 */
	public function isActive():Bool;

	/**
	 * Set the object to be either active or not, which will all `update()` to be called during the update cycle or skipped.
	 * 
	 * @param active Indicate if the object should be active or not.
	 */
	public function setActive(active:Bool):Void;

	/**
	 * Update logic for the object. Ideal for the change of state or AI specific logic.
	 * 
	 * @param dt Time elapsed since last frame, normalized.
	 */
	public function update(dt:Float):Void;

}

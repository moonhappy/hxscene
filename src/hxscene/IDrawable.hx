package hxscene;

/**
 * Interface of a Drawable type.
 * 
 * Has methods to call on draw cycle of the game loop.
 */
interface IDrawable {

	/**
	 * The draw layer specifies the ordering of when to call the object's `draw()` method in the draw cycle, relative to other objects.
	 */
	public var drawLayer:Int;

	/**
	 * The current visibility state of the object.
	 * 
	 * @return If `true` the object's `draw()` method will be called during the draw cycle, otherwise it will be skipped.
	 */
	public function isVisible():Bool;

	/**
	 * Sets whether the object is visible or not. Visible objects will have `draw()` called, otherwise the object will be skipped during draw cycle.
	 * 
	 * @param visible If `true` the object's `draw()` method will be called during the draw cycle, otherwise it will be skipped.
	 */
	public function setVisible(visible:Bool):Void;
	
	/**
	 * The draw logic of the object. State should not be altered during the draw logic, as that is better handled by IUpdateable logic.
	 */
	public function draw():Void;

}

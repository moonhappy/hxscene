package hxscene;

/**
 * Interface of a Loadable type.
 * 
 * Has methods to call to load and release resources.
 */
interface ILoadable {

	/**
	 * The current load state of the object.
	 * 
	 * @return If `true` the object has been loaded. That is, successful call of the `load()` method.
	 */
	public function isLoaded():Bool;

	/**
	 * Logic to handle the loading of object specific resources.
	 */
	public function load():Void;

    /**
     * Logic to handle the release of object resources.
     */
    public function release():Void;

}

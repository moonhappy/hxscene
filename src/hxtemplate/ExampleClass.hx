package hxtemplate;

/**
 * Simple class with a single property, which is `field`.
 * @see <https://github.com/HaxeFoundation/dox/wiki/How-to-document-Haxe-code>
 */
class ExampleClass {
	/**
	 * When class is initialised, this property will be set to "some".
	 */
	public var field:String;

	/**
	 * Default constructor.
	 * 
	 * Sets default value of "some" to the public property `field`.
	 */
	public function new() {
		field = "some";
	}
}

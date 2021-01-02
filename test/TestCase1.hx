import hxtemplate.ExampleClass;

class TestCase1 extends utest.Test {
	var example:ExampleClass;

	// synchronous setup
	public function setup() {
		example = new ExampleClass();
	}

	function testFieldIsSome() {
		utest.Assert.equals("some", example.field);
	}
}


class TestCaseActor extends utest.Test {
	var hiWorldActor:TestActor;

	// synchronous setup
	public function setup() {
		hiWorldActor = new TestActor();
	}

	function testActorInitial() {
		// Check initial state
		hiWorldActor.draw();
		utest.Assert.equals("Hello World", hiWorldActor.message);
	}
}

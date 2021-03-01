
class TestCaseActor extends utest.Test {

	var hiWorldActor:TestActor;

	// synchronous setup
	public function setup() {
		hiWorldActor = new TestActor();
	}

	function testActorInitial() {
		// Check initial state
		utest.Assert.equals("Hello World", hiWorldActor.message);
	}

	function testActorSignal() {
		hiWorldActor.signalCue("test_actor__bye", null);
		utest.Assert.equals("Bye World", hiWorldActor.message);
	}

}

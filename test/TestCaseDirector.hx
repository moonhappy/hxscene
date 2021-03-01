import hxscene.Director;

class TestCaseDirector extends utest.Test {

	var hiWorldDirector:Director;
    var hiWorldActor:TestActorObidient;

	// synchronous setup
	public function setup() {
		this.hiWorldDirector = new Director();
        this.hiWorldActor = new TestActorObidient();
        this.hiWorldDirector.addActor(this.hiWorldActor);
	}

	function testDirectorInitial() {
		// Check initial state
		utest.Assert.equals("Director hasn't said anything yet", hiWorldActor.message);
	}

	function testDirectorSignal() {
		hiWorldDirector.signalCue("director_says_hi", null);
		utest.Assert.equals("Director says hi", hiWorldActor.message);
	}
	
}

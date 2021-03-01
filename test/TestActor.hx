import hxscene.Actor;

// Example Actor.
// Performs "Hello World" until signalled on cue to perform "bye world".
class TestActor extends Actor {

	public var message = "Hello World";

	public override function new() {
		super();
		registerCue("test_actor__bye", sayBye);
	}

	public function sayBye(userData:Any) {
		message = "Bye World";
	}

}

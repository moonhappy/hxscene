import hxscene.Actor;

// Another example Actor.
// However, this actor will only monitor cues issued from particular director.
class TestActorObidient extends Actor {

	public var message = "Director hasn't said anything yet";

	public function new() {
		super();
		registerCue(10, sayHi);
	}

	public function sayHi(userData:Any) {
		message = "Director says hi";
	}

}

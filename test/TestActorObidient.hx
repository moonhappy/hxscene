import hxscene.Actor;

// Another example Actor.
// However, this actor will only monitor cues issued from particular director.
class TestActorObidient extends Actor {
	public var message = "Director hasn't said anything yet";

    public override function new(director:Director) {
		super();
		onCue("director_says_hi", "sayHi", director);
	}

	public function sayHi() {
		message = "Director says hi";
	}

	public override function draw() {
		trace(message);
	}
}

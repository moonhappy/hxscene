import hxscene.Director;

// Example director.
// Monitors the time and will signal the cue for Hello World actor to start
// performing the less famous "bye world" routine, after 3 seconds have passed.
class TestDirector extends Director {
	public var timePassed:Float;
    public var cueFired:Bool;
    public var subCueFired:Bool;

	public override function new() {
		super();
		this.timePassed = 0;
        this.cueFired = false;
        this.subCueFired = false;
	}

    public function update(dt:Float) {
        this.timePassed += dt;
        if (this.cueFired == false && this.timePassed > 3.0) {
            signalCue("hiworld_bye");
            this.cueFired = true;
        } else if (this.cueFired == true && this.timePassed > 4.0) {
            signalCue("director_says_hi");
            this.subCueFired = true;
        }
    }
}

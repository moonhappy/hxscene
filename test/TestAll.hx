
class TestAll {
	static public function main() {
		// the long way
		var runner = new utest.Runner();
		runner.addCase(new TestCase1());
		utest.ui.Report.create(runner);
		runner.run();
	}
}

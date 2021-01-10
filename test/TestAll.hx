
class TestAll {
	static public function main() {
		// Run all the test cases...
		var runner = new utest.Runner();
		runner.addCase(new TestCaseActor());
		utest.ui.Report.create(runner);
		runner.run();
	}
}

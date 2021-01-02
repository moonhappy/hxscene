![hxSCENE](TITLE.svg)

[![Build Status](https://travis-ci.com/moonhappy/hxscene.svg?branch=main)](https://travis-ci.com/moonhappy/hxscene)

Manage game objects using a theatre/stage like paradigm, using scene constructs.

# Testing

You have the option to run the project unit tests in the following ways:

- Directly from Visual Studio Code as a HXCPP build; or
- From CLI.

## Testing: Visual Studio Code

The project has the Visual Studio Code `.vscode` configuration pre-defined so that building and running the project in debug mode is enabled "out-of-the-box". Simply pressing `F5` will initiate a build and run the unit tests in debug mode, which will exercise the project source code and allow runtime inspection using break-points. However, some inital configuration is needed first (assuming Haxe has already been installed):

1. Install the [Haxe Extension Pack](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack) extension in VS Code.
2. Install hxcpp: `haxelib install hxcpp`
3. Install utest: `haxelib install utest`
4. Install cpp debug server: `haxelib install hxcpp-debug-server`
5. Run "HXCPP: Setup" from VS Code command palette (`F1` or `CMD+SHIFT+P`)
6. Restart VS Code (just to be safe), then hit `F5` to initiate build and debug run of the unit tests

After the inital steps are completed, you don't need do these steps again.

## Testing: CLI

Running unit tests via the CLI will not have the advantage of debugging support, but are a quick and easy solution to validate the project using the unit tests. Likewise, it allows continuous integration solutions a means to build and test the project.

To run unit tests on the CLI, simply enter the following in Terminal:
```sh
haxe test.hxml
```

# Transparency

A command-line tool for transforming a color with transparency to one without trasparency.

## Motivation

It is not possible to have transparency in iOS app icons. If one tries this, the app icon display the transparent parts of the image in black. However, for a given transparent color on a given background, one can calculate the closest color without transparency using the following formula:

```
target = opacity * original + (1 - opacity) * background
```

## Installation 

### Manual installation

You can build the project yourself using the Xcode command-line tools like this:

```
cd /path/to/transparency
swift build
cd .build/debug
transparency -c 90:200:250 -o 0.3
```

Alternatively copy the generated binary to a folder in your $PATH so you can run the tool from everywhere. Make sure you have permissions to change the desired directory (`/usr/local/bin` in this example)

```
cd /path/to/transparency
swift build
cp .build/debug/transparency /usr/local/bin
transparency -c 90:200:250 -o 0.3
```

### Installation during development

The Xcode project has a `Copy phase` that copies the `transparency` binary to `/usr/local/bin` every time the project is built. Make sure you have permissions to change this directory.

## Usage

To print the usage help for the tool to the console, run:

```
transparency -h
```

## Dependencies

* [Swift Argument Parser](https://github.com/apple/Swift-Argument-Parser)

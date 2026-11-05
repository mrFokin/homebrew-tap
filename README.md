# mrFokin/homebrew-tap

Install: `brew install mrfokin/tap/wgplex`, then follow the caveats ([wgplex](https://github.com/mrFokin/wgplex)).

Local archive (testing): `F=$(brew --repository mrfokin/tap)/Formula/wgplex.rb; sed -i '' -e "s|^  url .*|  url \"file:///path/to/wgplex-0.1.0-darwin-universal.tar.gz\"|" -e "s|^  sha256 .*|  sha256 \"$(shasum -a 256 /path/to/wgplex-0.1.0-darwin-universal.tar.gz | cut -d' ' -f1)\"|" "$F"`

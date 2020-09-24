brew_install:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cocoapods_install:
	# sudo gem install cocoapods 
	brew install cocoapods

swiftlint_install:
	brew install swiftlint

setup:
	-make brew_install
	-make cocoapods_install
	-make swiftlint_install
	cd ChuckNorrisFacts && pod install

open_project:
	xed ChuckNorrisFacts/ChuckNorrisFacts.xcworkspace

lets_go:
	make setup
	make open_project

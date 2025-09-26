# Adjust these if you move files
JAR := venus-61c.dev.jar
SRC := src/main.s

# Install Node deps in ./gui
.PHONY: setup
setup:
	cd gui && npm init -y
	cd gui && npm install express ws

# Start Node server (serves gui/public and spawns Venus)
.PHONY: web
web:
	cd gui && node server.js

# Run Venus alone in console
.PHONY: run
run:
	java -jar $(JAR) $(SRC)

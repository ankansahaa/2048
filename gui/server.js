const express = require("express");
const http = require("http");
const {spawn} = require("child_process");
const WebSocket = require("ws");
const readline = require("readline");

const app = express();
app.use(express.static("public"));           // serves ./public/index.html
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const venus = spawn("java", ["-jar", "../venus-61c.dev.jar", "../src/main.s"], {
  stdio: ["pipe", "pipe", "inherit"]
});

const rl = readline.createInterface({ input: venus.stdout });
rl.on("line", line => {
  // forward each line from your assembly to the browser
  wss.clients.forEach(ws => ws.readyState === ws.OPEN && ws.send(line));
});

wss.on("connection", ws => {
  ws.on("message", msg => {
    // expect 'w','a','s','d' (or map here from arrows if you prefer)
    venus.stdin.write(String(msg) + "\n");
  });
});

venus.on("exit", code => {
  console.log("Venus exited", code);
  process.exit(code ?? 1);
});

const PORT = 8080;
server.listen(PORT, () => console.log(`Open http://localhost:${PORT}`));

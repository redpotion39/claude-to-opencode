# claude-to-opencode

Go bridge เชื่อม **Claude Code** ↔ **opencode-go** (Anthropic-format compatible)

```
Claude Code  →  http://localhost:4000  (bridge.exe)  →  https://opencode.ai/zen/go/v1/...
```

## Models ที่รองรับ (13 ตัว)

| Model | Format |
|---|---|
| minimax-m3, minimax-m2.7 | Anthropic |
| glm-5.2, glm-5.1 | Anthropic |
| qwen3.7-max, qwen3.7-plus, qwen3.6-plus | Anthropic |
| kimi-k2.7-code, kimi-k2.6 | OpenAI |
| mimo-v2.5, mimo-v2.5-pro | OpenAI |
| deepseek-v4-pro, deepseek-v4-flash | OpenAI |

Bridge จะ auto-detect format ของ model แล้วส่งไป endpoint ที่ถูกต้อง

## วิธีใช้

### 1. ตั้ง API key ใน `.env`
```
OPENCODE_GO_API_KEY=sk-...
```
(ได้ key จาก https://opencode.ai/auth → เลือก **OpenCode Go**)

### 2. รัน bridge
```powershell
cd D:\project26\claude-to-opencode
.\start.cmd
```
(หรือรัน `bridge.exe` ตรง ๆ)

### 3. ตั้ง Claude Code
เปิด terminal ใหม่:
```powershell
$env:ANTHROPIC_BASE_URL = "http://localhost:4000"
$env:ANTHROPIC_API_KEY = "sk-any"
claude
```

### ตั้งถาวร
```powershell
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "http://localhost:4000", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "sk-any", "User")
```

## โครงสร้าง
```
claude-to-opencode/
├── bridge.exe       # Go proxy (compiled)
├── start.cmd        # Windows launcher
├── .env             # OPENCODE_GO_API_KEY
├── main.go          # source (rebuild with `go build`)
└── README.md
```

## เพิ่ม model ใหม่
แก้ `main.go` ในส่วน `openAIModels` map:
```go
var openAIModels = map[string]bool{
    "your-new-model": true,
    ...
}
```
แล้ว rebuild: `go build -o bridge.exe .`

## Build จาก source
```powershell
go build -o bridge.exe .
```

## Troubleshooting

- **Connection refused** — bridge ไม่ได้รัน ลอง `netstat -ano | Select-String 4000`
- **401 / AuthError** — key ใน `.env` ผิด
- **Empty response** — model ตอบ "" ลอง prompt ยาวขึ้น
- **Port ใช้แล้ว** — `set PROXY_PORT=4001` ก่อนรัน start.cmd

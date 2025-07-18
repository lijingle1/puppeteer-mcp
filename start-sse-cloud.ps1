$env:CLOUD_SERVICE = 'true'
$env:PORT = '3000'
Write-Host 'Starting Puppeteer MCP SSE Cloud Server...'
npx -y tsx index.ts

# AutoCut Studio V3.4 Professional

Editor web de vídeo com motor automático e renderização FFmpeg dentro de Docker.

## O que esta versão entrega

- Frontend servido pelo próprio backend: um único serviço
- Dockerfile já instala FFmpeg, FFprobe e fontes para legendas
- Render real com H.264/AAC e faststart
- Cortes automáticos por detecção de cenas
- Detecção de picos de áudio para pontos de batida
- Transcrição OpenAI com timestamps de palavras
- Legendas em blocos ou palavra por palavra via ASS/libass
- Animação de entrada/escala nas palavras
- Transições reais via `xfade`
- Zoom automático e efeitos cinematográficos
- Mixagem de áudio e ducking básico da música contra a faixa de voz
- Imagens tratadas como clipes com movimento
- Projetos persistidos em JSON no servidor
- Blueprint `render.yaml` para Render
- Health check que verifica a versão do FFmpeg

## Deploy no Render pelo celular

1. Coloque esta pasta em um repositório GitHub.
2. No Render, crie `New > Web Service`.
3. Conecte o repositório.
4. Selecione runtime `Docker`.
5. O Render encontra `./Dockerfile` automaticamente.
6. Em Environment, adicione `OPENAI_API_KEY` com a sua chave nova. Nunca coloque a chave no frontend, Dockerfile ou GitHub.
7. Deploy.

O `render.yaml` já descreve as variáveis e o health check.

## Armazenamento

O projeto usa `backend/data` para uploads, projetos e renders. Em Render, o filesystem padrão é efêmero. Para uso contínuo, anexe um Persistent Disk em `/app/backend/data` ou migre uploads/outputs para armazenamento de objetos. Persistent Disk exige serviço pago no Render.

## Execução local

```bash
cp backend/.env.example backend/.env
# edite backend/.env e coloque OPENAI_API_KEY

docker compose up --build
```

Abra `http://localhost:8787`.

## Segurança

- Não commite `.env`.
- Não coloque API keys no HTML/JavaScript do frontend.
- A chave OpenAI deve ficar em Environment Variables do Render.
- Se uma chave já foi exposta, revogue-a e crie outra.

## Observação sobre o nível profissional

A V3.4 implementa o caminho real de renderização. Para uma operação SaaS em escala, o próximo passo é separar renderização em Background Worker/Workflow, usar object storage e banco de dados, além de fila de jobs e autenticação. O editor atual já deixa a interface e o motor preparados para essa evolução.
